json.array! @products do |product|
  # json.id product.id
  json.name product.name
  json.highlight product.pg_search_highlight
end
