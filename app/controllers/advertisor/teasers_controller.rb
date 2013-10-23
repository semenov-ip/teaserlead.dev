class Advertisor::TeasersController < Advertisor::ApplicationController

  def index
    @teasers = Teaser.all
  end

  def show
    @teaser = Teaser.find(params[:id])
  end

  def new
    @teaser = Teaser.new
  end

  def edit
    @teaser = Teaser.find(params[:id])
  end

  def create
    @teaser = Teaser.new(teaser_params)

    if @teaser.save
      redirect_to teaser_path(@teaser)
      flash[:notice] = 'Teaser was successfully created.'
    else
      render 'new'
    end
  end

  def update
    @teaser = Teaser.find(params[:id])
    if @teaser.update(teaser_params)
      redirect_to teaser_path(@teaser)
      flash[:notice] = 'Teaser was successfully updated.'
    else
       render 'edit'
    end
  end

  def destroy
    @teaser = Teaser.find(params[:id])
    @teaser.destroy
    redirect_to teasers_path
  end

private
  def teaser_params
    params.require(:teaser).permit(:text, :image, :advertisement_campaign_id).merge user: current_user
  end

end
