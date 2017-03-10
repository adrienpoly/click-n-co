class OrdersController < ApplicationController
  before_action :find_order, only: [:show]

  def index
    @orders = Order.where(user: current_user)
    @orders_in  = @orders.where("pick_up_at > ?", Date.today ).order(:pick_up_at)
    @orders_out = @orders.where("pick_up_at < ?", Date.today ).order(:pick_up_at)
  end

  def create
    @mycart = []
    session[:cart].each do |shop_id, orders|
      sum = 0
      @order = Order.new()
      @order.user = current_user
      @order.shop_id = shop_id
      @order.pick_up_at = build_date(params[:other][:day], params[:other][:hour])
      @order.instructions = params[:order][:instructions]
      @order.save
      orders.each do |product_id, product|
        ordered_product = OrderedProduct.new(
          order: @order,
          product_id: product_id,
          quantity: product['qty'],
          order_price: product['price'])
        ordered_product.save
        sum += ordered_product.order_price * ordered_product.quantity
      end
      @order.total_price = sum
      @order.confirmed!
      @order.save
      @mycart << @order
    end
    session[:cart] = {}
    #redirect_to new_order_payment_path(@order), notice: 'Order was successfully created.'
    redirect_to new_order_payment_path(@order, my_cart: @mycart)
  end

  def show
    #@order = Order.where(status: :confirmed).find(params[:id])
    render layout: false
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    if order.ready?
      OrderMailer.ready(order).deliver_now
    elsif order.canceled?
      OrderMailer.canceled(order).deliver_now
    end
    redirect_to retailer_shop_path(order.shop)
    #notice: ''
  end

  def clear_session_cart
    session[:cart] = {}
    redirect_to root_path, notice: 'Session was successfully cleared.'
  end

  private

  def find_order
    #@order = Order.find(params[:order_id])
    @order = Order.find(params[:id])
  end

  def build_date(day, hour)
    hour = hour + "h" unless hour.end_with?("h")
    date = DateTime.parse(day + "T" + hour)
  end

  def order_params
    params.require(:order).permit(:status, :instructions)
  end
end







