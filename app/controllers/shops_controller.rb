class ShopsController < ApplicationController
  before_action :find_shop, only: [:show]
  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.new
  end


  private

  def find_shop
    @shop = Shop.find(params[:shop_id])
  end
end
