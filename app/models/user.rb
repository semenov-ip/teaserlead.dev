# coding:UTF-8
class User < ActiveRecord::Base

  serialize :roles, Array

  has_secure_password

  validates :email, email: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_presence_of :password, on: :create

  # Добавить роль
  # @params [String|Symbol] role Роль
  # @return [Array] Массив ролей
  def add_role(role)
    roles.push(role) if !has_role?(role) && check_role(role)
  end

  # Удалить роль
  # @params [String|Symbol] role Роль
  # @return [Array] Массив ролей
  def remove_role(role)
    roles.delete(role) if check_role(role)
  end

  # Проверить наличие роли у пользователя
  # @params [String|Symbol] role Роль
  # @return [Boolean] Принадлежность пользователя роли
  def has_role?(role)
    roles.include?(role)
  end

  private

  # Проверить существование роли в конфигурации системы
  # @params [String|Symbol] role Роль
  # @return [Boolean] Существует такая роль или нет
  def check_role(role)
    raise TypeError, "Role doesn't exist. Check if Argument is Symbol" unless configus.roles.include?(role)
    if role == :user
      return false
    else
      return true
    end
  end
end
