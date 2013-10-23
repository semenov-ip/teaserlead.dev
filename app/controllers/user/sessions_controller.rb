class User::SessionsController < ApplicationController

  def new
    @login_form = LoginForm.new
  end

  def create
    @login_form = LoginForm.new params[:login_form]
    raise UserService::ServiceError.new unless @login_form.valid?
    user = UserService.authenticate(@login_form.email, @login_form.password)
    sign_in user
    redirect_to user_path
  rescue UserService::ServiceError => e
    flash[:error] = e.inspect
    render :action => :new
  end

  def destroy
    sign_out
    flash[:notice] = "До новых встреч!"
    redirect_to root_path
  end

end
