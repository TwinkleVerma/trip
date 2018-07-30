class Picture < ApplicationRecord
  belongs_to :profile, polymorphic: true
end
