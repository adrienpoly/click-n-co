class OrdersController < ApplicationController
  before_action :find_order, only: [:show]
  def index
    @orders = Order.all
  end

  def show
    @order = Order.new
  end

  private

  def find_order
    @order = Order.find(params[:order_id])
  end
end
