class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :create_update_etsy, :destroy]

  # GET /products
  def index
    if params[:q].present?
      new_q = {}
      params[:q].each do |k,v|
        new_q[k] = k == 'quantity_in' ? Product.quantity_search(v) : v
      end
      # puts new_q
    end
    @search = Product.ransack(new_q)
    @search.sorts = 'id asc' if @search.sorts.empty?
    @products = @search.result.paginate(page: params[:page], per_page: 100)

    @filtered_params_for_view = params[:q].present? ? params[:q].reject{ |k,v| !v.present? } : {}
    # puts @filtered_params_for_view.present?
    products_filtered_id_arr = Product.ransack(new_q).result.pluck(:id)
    #puts "@products_filtered - "+@products_filtered.to_s
      if params['file_type'].present? && params['file_type'] == 'ebay'
  	    if products_filtered_id_arr.size > 1500
  		    Product.delay.create_ebay_file(products_filtered_id_arr, params['file_type'])
  		    flash[:notice] = 'Задача запущена. Ожидайте письма о завершении'
  		    redirect_to products_path
  		  else
  		 	  Product.create_ebay_file(products_filtered_id_arr, params['file_type'])
  	    	redirect_to '/complete_ebay.csv'
  	    end
    	else
        # if params['file_type'] == 'redir'
        #   @decors_all_redir = Decor.all.order(:id)
        #   filename = "insales_decor_redir.csv"
        # end
        # if params['file_type'] == 'full'
        #   @decors_all = Decor.all.order(:id)
        #   filename = "insales_decor.csv"
        # end
        #
    		# respond_to do |format|
    		# 	format.html
    		# 	format.xml
    		# 	format.csv do
    		# 	  headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
    		# 	  headers['Content-Type'] ||= 'text/csv'
    		# 	end
    		#end
        if params['file_type'].present? && params['file_type'] == 'full'
              respond_to do |format|
                if @filtered_params_for_view.present?
                format.csv {send_data Product.where(id: products_filtered_id_arr).to_csv, filename: "product_filtered.csv" }
                else
                format.csv {send_data Product.order(:id).to_csv, filename: "product_full.csv" }
                end
              end
          end
	    end
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /products/1
  def update
  respond_to do |format|
    if @product.update(product_params)
      format.html { redirect_to products_url, notice: "Product was successfully updated." }
      format.json { render :show, status: :ok, location: @product }
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @product.errors, status: :unprocessable_entity }
    end
  end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

# POST /products
  def delete_selected
    @products = Product.find(params[:ids])
    @products.each do |product|
        product.destroy
    end
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { render json: { :status => "ok", :message => "destroyed" } }
    end
  end

  def xml_import
    Rails.env.development? ? Services::Import.product : ImportProductJob.perform_later
    Rails.env.development? ? Services::Import.product_quantity : ImportProductQuantityJob.perform_later
    redirect_to products_path, notice: 'Запущен процесс Обновление Товаров InSales. Дождитесь письма о выполнении обновления'
  end

  def create_load_ebay_file
    if EbaySetup.first.present?

    products_ids = Product.ebay_products.map{ |a| a.id if a.price_dollar.present? }.reject(&:blank?)
    file_type = "ebay_for_load"
    filename = "complete_"+file_type+".csv"
    Product.create_ebay_file( products_ids, file_type )
    EbayFtpService.send_file( filename )
    flash[:notice] = 'Задача запущена. Ожидайте письма о завершении'
    redirect_to products_path

    else
      flash[:notice] = 'Настройте интеграцию ebay'
    end

  end

  def create_update_etsy
    if EtsySetup.first.present?
      if @product.quantity > 0
      EtsyService.create_update(params[:product_id])
      flash[:notice] = 'Товар создан/обновлён'
      redirect_to products_path
      else
        flash[:notice] = 'Кол-во товара 0. Не можем создать листинг'
        redirect_back(fallback_location: products_path)
      end
    else
      flash[:notice] = 'Настройте интеграцию etsy'
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:sku, :title, :desc, :title_en, :desc_en, :cat, :oldprice, :price, :price_dollar, :quantity, :image, :url, :parametr, :ins_id, :ins_var_id, :ebay_id, :etsy_id)
    end
end
