class Product < ApplicationRecord
  belongs_to :product_category
  has_many :ordered_products
end
