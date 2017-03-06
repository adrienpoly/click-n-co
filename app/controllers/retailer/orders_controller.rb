class Retailer::OrdersController < ApplicationController

  def index
  end

  def show
    @order = Order.find(params[:id])
    @shop = Shop.find(params[:shop_id])
    #@orders = @shop.orders
    #@orders = @shop.orders
  end

end

