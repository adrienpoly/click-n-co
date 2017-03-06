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
    # products = Product.where("lower(name) like ?", "%#{search.downcase}%")
      # shops = Shop.near(address, 1)
      # products = Product.search_by_name_and_description(search.downcase).joins(:shop).merge(Shop.near(address, 1))
      # byebug
      if address.blank?
        products = Product.search_by_name_and_description(search.downcase)
      else
    #   # products = Shop.search_products_shops(search.downcase).near(address, 1)
    #   byebug
    #   products = Product.search_by_name_and_description(search.downcase).joins(:shop).includes(:latitude, :longitue).near(address, 1)
      # byebug
      # market_ids = Address.near(target_zipcode.to_s, radius).select("id").map(&:market_id)
      # markets = Market.includes(:address).where(:id => market_ids)
      # shop_ids = Shop.near(address, 1).select('id').map(&:product_id)
      # prodcuts = Product.includes(:shops).where(id: shop_ids).search_products_shops(search.downcase)
        # products = Shop.near(address, 1).joins(:products).merge(-> { Product.search_by_name_and_description(search.downcase) })
        # products = Product.search_by_name_and_description(search).with_pg_search_highlight
        # near = Shop.near(address, 1)
        # products = Product.search_by_name_and_description(search).joins(:shop).merge(near)
        # byebug
        products = Product.search_by_name_and_description(search.downcase)


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

