class Order < ApplicationRecord
  belongs_to :ordered_product
  belongs_to :user
end
