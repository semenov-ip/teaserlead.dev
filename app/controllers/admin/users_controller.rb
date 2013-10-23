class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find params[:id]
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Пользователь сохранен"
      redirect_to [:admin, @user]
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params_to_update)
      flash[:notice] = "Пользователь сохранен"
      redirect_to [:admin, @user]
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end

    def user_params_to_update
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end
end
