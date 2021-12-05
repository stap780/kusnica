class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_role!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  def index
    if params[:q].present?
      new_q = {}
      params[:q].each do |k,v|
        if k == 'quantity_in'
          value = Product.quantity_search(v)
          new_q[k] = value
        else
          new_q[k] = v
        end
      end
      # puts new_q
    end
    #@products = Product.all
    @search = Product.ransack(new_q)
    @search.sorts = 'id asc' if @search.sorts.empty?
    @products = @search.result.paginate(page: params[:page], per_page: 100)
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
    redirect_to products_path, notice: 'Запущен процесс Обновление Товаров InSales'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:sku, :title, :desc, :cat, :oldprice, :price, :quantity, :image, :url, :parametr, :ins_id, :ins_var_id, :ebay_id, :etsy_id)
    end
end
