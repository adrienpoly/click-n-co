class OrdersController < ApplicationController
  before_action :find_order, only: [:show]

  def index
    @orders = Order.where(user: current_user)
  end

  def create
    # byebug
    session[:cart].each do |shop_id, orders|
      sum = 0
      order = Order.new()
      order.user = current_user
      order.shop_id = shop_id
      order.save

      orders.each do |product_id, product|
        ordered_product = OrderedProduct.new(order: order,
          product_id: product_id, quantity: product['qty'],
          order_price: product['price'])
        # ordered_product.order = order
        # ordered_product.product_id = product_id
        # ordered_product.quantity = product['qty']
        # ordered_product.order_price = product['price']
        ordered_product.save
        sum += ordered_product.order_price * ordered_product.quantity
      end

    order.total_price = sum
    order.confirmed!
    order.save
    end
    session[:cart] = {}
    redirect_to orders_path, notice: 'Order was successfully created.'
  end

  def show
    @order = Order.new
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to retailer_shop_path(order.shop)
  end

  private

  def find_order
    @order = Order.find(params[:order_id])
  end

  def order_params
    params.require(:order).permit(:status)
  end
end


