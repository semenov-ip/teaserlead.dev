class Advertisor::AdvertisementCampaignsController < Advertisor::ApplicationController
  before_action :set_advertisement_campaign, only: [:show, :edit, :update, :destroy]

  # GET /advertisement_campaigns
  # GET /advertisement_campaigns.json
  def index
    @advertisement_campaigns = AdvertisementCampaign.all
  end

  # GET /advertisement_campaigns/1
  # GET /advertisement_campaigns/1.json
  def show
  end

  # GET /advertisement_campaigns/new
  def new
    @advertisement_campaign = AdvertisementCampaign.new
  end

  # GET /advertisement_campaigns/1/edit
  def edit
  end

  # POST /advertisement_campaigns
  # POST /advertisement_campaigns.json
  def create
    @advertisement_campaign = AdvertisementCampaign.new(advertisement_campaign_params)

    respond_to do |format|
      if @advertisement_campaign.save
        format.html { redirect_to @advertisement_campaign, notice: 'Advertisement campaign was successfully created.' }
        format.json { render action: 'show', status: :created, location: @advertisement_campaign }
      else
        format.html { render action: 'new' }
        format.json { render json: @advertisement_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advertisement_campaigns/1
  # PATCH/PUT /advertisement_campaigns/1.json
  def update
    respond_to do |format|
      if @advertisement_campaign.update(advertisement_campaign_params_to_update)
        format.html { redirect_to @advertisement_campaign, notice: 'Advertisement campaign was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @advertisement_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advertisement_campaigns/1
  # DELETE /advertisement_campaigns/1.json
  def destroy
    @advertisement_campaign.destroy
    respond_to do |format|
      format.html { redirect_to advertisement_campaigns_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertisement_campaign
      @advertisement_campaign = AdvertisementCampaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advertisement_campaign_params
      params.require(:advertisement_campaign).permit(:name, :url, :category_id, teasers_attributes: [ :text, :image])
    end

    def advertisement_campaign_params_to_update
      params.require(:advertisement_campaign).permit(:name, :url, :category_id, teasers_attributes: [ :id, :text, :image, :_destroy])
    end
end
