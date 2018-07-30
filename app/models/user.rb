class User < ApplicationRecord
  has_many :bokkings
  has_many :pictures, as: :profile
end
