class Order < ApplicationRecord
  has_many :ordered_products
  belongs_to :user
  belongs_to :shop
  enum status: [:confirmed, :ready, :picked_up, :canceled]
end
