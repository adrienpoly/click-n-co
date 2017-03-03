module PagesHelper
  def carts_qantity(carts)
    sum = 0
    carts.each do |shop_id, cart|
      sum += cart_quantity(cart)
    end
    sum
  end

  def cart_quantity(cart)
    sum = 0
    cart.each do |product_id, product|
      sum += product['qty']
    end
    sum
  end
end
