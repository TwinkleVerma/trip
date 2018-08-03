class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #:lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :confirmable
  has_many :bookings, dependent: :destroy
  has_one :image,as: :imageable, dependent: :destroy
end
