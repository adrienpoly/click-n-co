module ShopsHelper
  def distance(dist)
    return '' unless dist
    if dist > 1
      return "#{dist.round(1)} km"
    else
      return "#{(dist.round(2) * 1000).truncate} m"
    end
  end

  def cart_total(carts)
    sum = 0
    carts.each do |shop_id, cart|
      sum += cart_sub_total(cart)
    end
    sum
  end



  def cart_sub_total(cart)
    sum = 0
    cart.each do |product_id, product|
      sum += product['qty'] * product['price']
    end
    sum
  end
end
