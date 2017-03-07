class Product < ApplicationRecord
  belongs_to :product_category
  has_many :ordered_products
  belongs_to :shop
  include PgSearch
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :short_description, :description ],
    using: {
      tsearch: {
        dictionary: "french",
        highlight: {
          start_sel:  '<b>',
          stop_sel:   '</b>'
        }
      }
    }


  def self.search(search, address = "")
      if address.blank?
        products = Product.search_by_name_and_description(search.downcase)
      else
        @shop_ids = Shop.near(address, 3).to_a.pluck(:id)
        products = Product.where(shop_id: @shop_ids).search_by_name_and_description(search)
      end

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

