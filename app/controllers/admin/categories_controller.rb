class Admin::CategoriesController < Admin::ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find params[:id]
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find params[:id]
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Пользователь сохранен"
      redirect_to [:admin, @category]
    else
      render 'new'
    end
  end

  def update
    if @category.update(category_params_to_update)
      flash[:notice] = "Пользователь сохранен"
      redirect_to [:admin, @category]
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:email, :password, :password_confirmation, :role)
    end

    def category_params_to_update
      params.require(:category).permit(:email, :password, :password_confirmation, :role)
    end
end
