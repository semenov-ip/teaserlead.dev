class Admin::SitesController < Admin::ApplicationController

  def index
    @sites = Site.all
  end

  def show
    @site = Site.find params[:id]
  end

  def new
    @site = Site.new
  end

  def edit
    @site = Site.find params[:id]
  end

  def create
    @site = Site.new(site_params)

    if @site.save
      flash[:notice] = "Пользователь сохранен"
      redirect_to [:admin, @site]
    else
      render 'new'
    end
  end

  def update
    @site = Site.find params[:id]
    if @site.update(site_params_to_update)
      flash[:notice] = "Пользователь сохранен"
      redirect_to [:admin, @site]
    else
      render 'edit'
    end
  end

  def destroy
    @site.destroy
    redirect_to admin_sites_path
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:email, :password, :password_confirmation, :role)
    end

    def site_params_to_update
      params.require(:site).permit(:email, :password, :password_confirmation, :role)
    end
end
