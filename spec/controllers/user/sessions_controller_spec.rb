# coding: UTF-8
require 'spec_helper'

describe User::SessionsController do

  it "GET :new" do
    get :new
    response.should be_success
  end

  describe "POST :create" do

    it "User authorization" do
      request.env["HTTP_REFERER"] = root_path
      user = FactoryGirl.create :user
      password = FactoryGirl.attributes_for(:user)[:password]
      post :create, login_form: {email: user[:email], password: password}
      response.should be_redirect
      session[:user_id].should == user.id
    end
  end

  it "DELETE :destroy" do
    delete :destroy
    response.should be_redirect
    session[:user_id].should be_nil
  end

end
