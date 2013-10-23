# coding: UTF-8

module AuthHelper
  extend ActiveSupport::Concern

  def sign_in(user)
    user.update_attribute(:last_sign_in_at, DateTime.now)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def signed_in?
    session[:user_id]
  end

  def authenticate_user!
    unless signed_in?
      flash[:notice] = 'Необходимо авторизоваться'
      redirect_to new_session_path
    end
  end

  def authenticate_admin!
    unless current_user.admin?
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= self.session[:user_id] && User.find_by_id(self.session[:user_id])
  end

  def sign_in_by_token
    if params[:auth_token].present?
      user = ::User.find_by_auth_token!(params[:auth_token])
      sign_in(user)
    end
  end

end
