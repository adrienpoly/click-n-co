class Retailer::OrdersController < ApplicationController

  def index
  end

  def show
    @tab_status = ["pending", "confirmed", "ready", "picked_up", "canceled"]
    @order = Order.find(params[:id])
    @shop = Shop.find(params[:shop_id])
    @nbr_circles = @tab_status.index(@order.status)
    #@orders = @shop.orders
    #@orders = @shop.orders
  end

end

