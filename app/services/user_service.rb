# encoding:UTF-8
class UserService < BaseService
  class BlankResponse < ServiceError; end
  class UserNotFound < ServiceError; end

  # Авторизация пользователея
  # @param [String] login логин
  # @param [String] password пароль
  # @return [User] Системный пользователь
  def self.authenticate(login, password)
    user = User.find_by_email(login).try(:authenticate, password)
    raise BlankResponse.new unless user.present?
    user
    rescue => e
      raise ServiceError.new e
  end

end
