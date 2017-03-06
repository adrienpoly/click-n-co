class Order < ApplicationRecord
  has_many :ordered_products
  belongs_to :user
  belongs_to :shop
  enum status: [:pending, :confirmed, :ready, :picked_up, :canceled]
end






