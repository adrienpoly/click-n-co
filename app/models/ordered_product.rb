class OrderedProduct < ApplicationRecord
  belongs_to :product
  has_many :orders
end
