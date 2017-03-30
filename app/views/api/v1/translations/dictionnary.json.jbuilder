# json.array! @words do |word|
#   # json.id product.id
#   json.francais         shop.name
#   json.address      shop.address
#   json.lng          shop.longitude
#   json.lat          shop.latitude
#   json.category_id  shop.category_id
#   json.photo_url    "https://res.cloudinary.com/adrien/image/upload/" + shop.photo.path
# end
json.array! @words.each do |key, value|
  json.francais key
  json.argomuch value
end
