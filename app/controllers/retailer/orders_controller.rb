class Retailer::OrdersController < ApplicationController

  def index
  end

  def show
    @order = Order.find(params[:id])
    @index = Order.statuses[@order.status]
  end

end





