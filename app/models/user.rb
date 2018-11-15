
class User < ApplicationRecord
  rolify

  # Include default devise modules. Others available are:
  #:lockable, :timeoutable and :omniauthable
  devise devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  has_many :crews, dependent: :destroy
  has_many :logs, dependent: :destroy
  has_many :flights, through: :crews
  has_many :bookings, dependent: :destroy
  has_one :image, as: :imageable, dependent: :destroy

  validates_format_of :name, with: /^[a-zA-Z0-9_\.]*$/, multiline: true
  validates :name, uniqueness: { case_sensitive: false }

  scope :select_field, ->(field) {select(field)}

  attr_writer :login
  after_create :send_reset_password_mail

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["name = :value OR lower(email) = lower(:value)", { value: login }]).first
    elsif conditions.key?(:name) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def login
    @login || name || email
  end

  def self.valid_login?(email, password)
    user = where(email: email).first
    [user&.valid_password?(password), user]
  end

  def reset_authentication_token!
    update_column(:authentication_token, Devise.friendly_token)
  end

  def send_reset_password_mail
    send_reset_password_instructions
  end
end
