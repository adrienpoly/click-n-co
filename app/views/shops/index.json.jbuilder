json.array! @shops do |shop|
  # json.id product.id
  json.name shop.name
  json.address shop.address
  json.lng shop.longitude
  json.lat shop.latitude
  json.category_id shop.category_id
end
