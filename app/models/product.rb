class Product < ApplicationRecord
  belongs_to :product_category
  has_many :ordered_products
  belongs_to :shop


  def self.search(search)
    products = Product.where("lower(name) like ?", "%#{search.downcase}%")
    hash = {}
    products.each do |product|
      if hash[product.shop.name].blank?
        hash[product.shop.name] = [product]
      else
        hash[product.shop.name] << product
      end
    end
    hash
  end
end

