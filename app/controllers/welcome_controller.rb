class WelcomeController < ApplicationController
  def index
    @login_form = LoginForm.new
  end

  def advertisers
  end

end
