class Product < ApplicationRecord
  belongs_to :product_category
  has_many :ordered_products
  belongs_to :shop
end

