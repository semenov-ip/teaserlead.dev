class Advertisor::UsersController < Advertisor::ApplicationController

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    @user.add_role(:advertisor)
    if @user.save
      sign_in @user
      redirect_to user_path
      flash[:notice] = 'User was successfully created.'
    else
      render 'new'
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path
      flash[:notice] = 'User was successfully updated.'
    else
       render 'edit'
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
