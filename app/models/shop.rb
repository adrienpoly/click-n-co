class Shop < ApplicationRecord
  belongs_to :user
  has_many :opening_hour
  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :category, presence: true
end
