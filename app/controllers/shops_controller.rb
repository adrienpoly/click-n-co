class ShopsController < ApplicationController
  before_action :find_shop, only: [:show]
  def index
    @shops = Shop.all
  end

  def show
    @shops = Shop.all
  end


  private

  def find_shop
    @shop = Shop.find(params[:id])
  end
end
