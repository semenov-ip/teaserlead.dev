class LoginForm < BaseForm
  attr_accessor :email, :password
  validates :password, :email, :presence => true
  validates :email, :email => true
end
