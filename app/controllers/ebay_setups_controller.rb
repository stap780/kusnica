class EbaySetupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ebay_setup, only: [:show, :edit, :update, :destroy]

  # GET /ebay_setups
  def index
    #@ebay_setups = EbaySetup.all
    @search = EbaySetup.all.ransack(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?
    @ebay_setups = @search.result.paginate(page: params[:page], per_page: 30)
  end

  # GET /ebay_setups/1
  def show
  end

  # GET /ebay_setups/new
  def new
    @ebay_setup = EbaySetup.new
  end

  # GET /ebay_setups/1/edit
  def edit
  end

  # POST /ebay_setups
  def create
    @ebay_setup = EbaySetup.new(ebay_setup_params)

    respond_to do |format|
      if @ebay_setup.save
        format.html { redirect_to ebay_setups_url, notice: "Ebay setup was successfully created." }
        format.json { render :show, status: :created, location: @ebay_setup }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ebay_setup.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /ebay_setups/1
  def update
  respond_to do |format|
    if @ebay_setup.update(ebay_setup_params)
      format.html { redirect_to ebay_setups_url, notice: "Ebay setup was successfully updated." }
      format.json { render :show, status: :ok, location: @ebay_setup }
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @ebay_setup.errors, status: :unprocessable_entity }
    end
  end
  end

  # DELETE /ebay_setups/1
  def destroy
  @ebay_setup.destroy
  respond_to do |format|
    format.html { redirect_to ebay_setups_url, notice: "Ebay setup was successfully destroyed." }
    format.json { head :no_content }
  end
  end

# POST /ebay_setups
  def delete_selected
    @ebay_setups = Ebay Setup.find(params[:ids])
    @ebay_setups.each do |ebay_setup|
        ebay_setup.destroy
    end
    respond_to do |format|
      format.html { redirect_to ebay_setups_url, notice: "Ebay setup was successfully destroyed." }
      format.json { render json: { :status => "ok", :message => "destroyed" } }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ebay_setup
      @ebay_setup = EbaySetup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ebay_setup_params
      params.require(:ebay_setup).permit(:ebay_username, :ebay_password)
    end
end
