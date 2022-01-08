class EtsySetupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_etsy_setup, only: [:show, :edit, :update, :destroy]

  # GET /etsy_setups
  def index
    #@etsy_setups = EtsySetup.all
    @search = EtsySetup.ransack(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?
    @etsy_setups = @search.result.paginate(page: params[:page], per_page: 30)
  end

  # GET /etsy_setups/1
  def show
  end

  # GET /etsy_setups/new
  def new
    @etsy_setup = EtsySetup.new
  end

  # GET /etsy_setups/1/edit
  def edit
  end

  # POST /etsy_setups
  def create
    @etsy_setup = EtsySetup.new(etsy_setup_params)

    respond_to do |format|
      if @etsy_setup.save
        format.html { redirect_to etsy_setups_url, notice: "Настройка создана" }
        format.json { render :show, status: :created, location: @etsy_setup }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @etsy_setup.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /etsy_setups/1
  def update
  respond_to do |format|
    if @etsy_setup.update(etsy_setup_params)
      format.html { redirect_to etsy_setups_url, notice: "Настройка обновлена" }
      format.json { render :show, status: :ok, location: @etsy_setup }
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @etsy_setup.errors, status: :unprocessable_entity }
    end
  end
  end

  # DELETE /etsy_setups/1
  def destroy
  @etsy_setup.destroy
  respond_to do |format|
    format.html { redirect_to etsy_setups_url, notice: "Etsy setup was successfully destroyed." }
    format.json { head :no_content }
  end
  end

# POST /etsy_setups
  def delete_selected
    @etsy_setups = Etsy Setup.find(params[:ids])
    @etsy_setups.each do |etsy_setup|
        etsy_setup.destroy
    end
    respond_to do |format|
      format.html { redirect_to etsy_setups_url, notice: "Etsy setup was successfully destroyed." }
      format.json { render json: { :status => "ok", :message => "destroyed" } }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_etsy_setup
      @etsy_setup = EtsySetup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def etsy_setup_params
      params.require(:etsy_setup).permit(:api_key, :api_secret, :code, :token, :secret)
    end
end
