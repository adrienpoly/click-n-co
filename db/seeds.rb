# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.destroy_all

Product.destroy_all
ProductCategory.destroy_all

user = User.new(email: 'adrienpoly@gmail.com', password: '123456')
user.save

user = User.new(email: 'lucie.lasagna@essec.edu', password: '123456')
user.save

categories = ["Plateaux Apéro", "Plateaux Découverte", "Portions", "Extras",
  "Vins", "Champagnes"]

categories.each do |categorie|
  ProductCategory.create(name: categorie)
end

def read_csv
  products = []
  csv_options = { col_sep: ';', quote_char: '"', headers: true, header_converters: :symbol }
  CSV.foreach('db/products.csv', csv_options) do |row|
    params = row.to_hash.delete_if { |key, _value| key.nil? }
    products << params
  end
  products
end

p products = read_csv

products.each do |product|
  product_category = ProductCategory.where(name: product[:product_category]).first
  new_product = Product.new()
  new_product.name = product[:name]
  new_product.short_description = product[:short_description]
  new_product.price = product[:price]
  new_product.product_category = product_category
  new_product.save
end
