class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #:lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :confirmable, authentication_keys: [:login]
  has_many :bookings, dependent: :destroy
  has_one :image,as: :imageable, dependent: :destroy
  validates_format_of :name, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validates :name, presence: :true, uniqueness: { case_sensitive: false }
  attr_writer :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["name = :value OR lower(email) = lower(:value)", { :value => login }]).first
    elsif conditions.has_key?(:name) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def login
    @login || self.name || self.email
  end

end
