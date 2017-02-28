class Shop < ApplicationRecord
  belongs_to :user
  has_many :opening_hour
  has_many :products
  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :category, presence: true
  has_many :product_categories, through: :products
end

