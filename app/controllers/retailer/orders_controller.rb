class Retailer::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    #@orders = @shop.orders
    #@orders = @shop.orders
  end

end

