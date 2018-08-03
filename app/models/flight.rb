class Flight < ApplicationRecord
  has_one :schedule, dependent: :destroy
  belongs_to :airline
end
