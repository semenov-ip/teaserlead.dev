class Admin::AdvertisementCampaignsController < Admin::ApplicationController

  def index
    @advertisement_campaigns = AdvertisementCampaign.all
  end

  def show
    @advertisement_campaign = AdvertisementCampaign.find params[:id]
  end

  def new
    @advertisement_campaign = AdvertisementCampaign.new
  end

  def edit
    @advertisement_campaign = AdvertisementCampaign.find params[:id]
  end

  def create
    @advertisement_campaign = AdvertisementCampaign.new(advertisement_campaign_params)

    if @advertisement_campaign.save
      flash[:notice] = "Пользователь сохранен"
      redirect_to [:admin, @advertisement_campaign]
    else
      render 'new'
    end
  end

  def update
    @advertisement_campaign = AdvertisementCampaign.find params[:id]
    if @advertisement_campaign.update(advertisement_campaign_params_to_update)
      flash[:notice] = "Пользователь сохранен"
      redirect_to [:admin, @advertisement_campaign]
    else
      render 'edit'
    end
  end

  def destroy
    @advertisement_campaign.destroy
    redirect_to admin_advertisement_campaigns_path
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def advertisement_campaign_params
      params.require(:advertisement_campaign).permit(:email, :password, :password_confirmation, :role)
    end

    def advertisement_campaign_params_to_update
      params.require(:advertisement_campaign).permit(:email, :password, :password_confirmation, :role)
    end
end
