module ShopsHelper
  def distance(dist)
    return '' unless dist
    if dist > 1
      return "#{dist.round(1)} km"
    else
      return "#{(dist.round(2) * 1000).truncate} m"
    end
  end

  def number_of_items(carts)
    return 0 if carts.blank?
    sum = 0
    carts.each do |shop_id, cart|
      sum += number_of_subitems(cart)
    end
    sum
  end

  def number_of_subitems(cart)
    return 0 if cart.blank?
    sum = 0
    cart.each do |_, product|
      sum += product['qty']
    end
    sum
  end

  def cart_total(carts)
    return 0 if carts.blank?
    sum = 0
    carts.each do |shop_id, cart|
      sum += cart_sub_total(cart)
    end
    sum.round(2)
  end

  def cart_sub_total(cart)
    return 0 if cart.blank?
    sum = 0
    cart.each do |product_id, product|
      sum += product['qty'] * product['price']
    end
    sum
  end
end
