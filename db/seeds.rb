
def clean_database
  OrderedProduct.destroy_all
  Order.destroy_all
  Product.destroy_all
  ProductCategory.destroy_all
  Shop.destroy_all
  Category.destroy_all
  User.destroy_all
end

def create_users
  owner = User.new(email: 'lucie.lasagna@essec.edu', password: '123456')
  owner.admin = true
  owner.save


  user = User.new(email: 'adrienpoly@gmail.com', password: '123456')
  user.admin = true
  user.save

  user = User.new(email: 'triboy.m@gmail.com', password: '123456')
  user.admin = true
  user.save

  user = User.new(email: 'piergiovanni@cegetel.net', password: '123456')
  user.admin = true
  user.save
  owner
end

def create_shops(owner)
  shops_by_cat = JSON.parse(open("db/yelp_shops.json","r").read)


  shops_by_cat.each do |category, shops|
    new_cat = Category.create!(name: category)
    # if Rails.env = "development"
    #   shops = shops.first(4)
    # end
    shops.each do |shop|
      new_shop = Shop.new(
        name: shop['name'],
        address: shop['address'],
        phone_number: shop['phone']
        )
      new_shop.category = new_cat
      new_shop.user = owner
      new_shop.send(:photo_url=, shop['image_url'],
       folder: 'click-n-co', use_filename: true, image_metadata: true)
      # new_shop.photo_url = shop['image_url']
      if new_shop.save
        p "#{new_shop.name} added"
      end
    end
  end
end


  # categories = ["Plateaux Apéro", "Plateaux Découverte", "Portions", "Extras",
  #   "Vins", "Champagnes"]

  # categories.each do |categorie|
  #   ProductCategory.create(name: categorie)
  # end

def read_csv
  products = {}
  csv_options = { col_sep: ';', quote_char: '"', headers: true, header_converters: :symbol }
  CSV.foreach('db/products.csv', csv_options) do |row|
    params = row.to_hash.delete_if { |key, _value| key.nil? }
    # products << params
    products[row[:shop_category]] = {} if products[row[:shop_category]].nil?
    products[row[:shop_category]][row[:product_category]] = [] if products[row[:shop_category]][row[:product_category]].nil?
    price = (row[:price].to_f / 100).round(1)
    product = { name: row[:name], short_description: row[:short_description], price: price }
    products[row[:shop_category]][row[:product_category]] << product
    # products[row[:shop_category]][row[:product_category]] = 1
  end
  products
end

def create_products
  p products = read_csv

  shops = Shop.all
  shops.each do |shop|
    shop_category = shop.category.name
    # products.each do |shop_category, product_catgories|
    unless products[shop_category].blank?
      products[shop_category].each do |product_category, products|
        new_product_category = ProductCategory.create!(name: product_category)
        products.each do |product|
          new_product = Product.new(
            name: product[:name],
            price: product[:price],
            short_description: product[:short_description])
          # new_product.name = product[:name]
          # new_product.short_description = product[:short_description]
          # new_product.price = product[:price]
          new_product.product_category = new_product_category
          new_product.shop = shop
          if new_product.save
            p "#{new_product.name} created"
          else
            p "error creating products #{prodcut}"
          end
        end
      end
    end
  end
end

def clean_products
  OrderedProduct.destroy_all
  Order.destroy_all
  Product.destroy_all
  ProductCategory.destroy_all
end
# owner = nil

clean_database

owner = create_users
owner = User.first if owner.blank?
create_shops(owner)
clean_products
create_products
