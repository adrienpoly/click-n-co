class Shop < ApplicationRecord
  belongs_to :user
  has_many :opening_hour
end
