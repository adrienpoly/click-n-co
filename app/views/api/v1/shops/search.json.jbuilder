json.array! @shops do |shop|
  # json.id product.id
  json.name         shop.name
  json.address      shop.address
  json.lng          shop.longitude
  json.lat          shop.latitude
  json.category_id  shop.category_id
  json.photo_url    "https://res.cloudinary.com/adrien/image/upload/" + shop.photo.path
end
