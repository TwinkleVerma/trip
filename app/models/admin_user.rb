class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  attr_writer :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['email = :value', { value: login }]).first
    elsif conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def login
    @login || email
  end

end
