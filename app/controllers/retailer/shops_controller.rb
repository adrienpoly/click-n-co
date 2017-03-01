class Retailer::ShopsController < ApplicationController
  def index
    if current_user.shops.one?
      redirect_to retailer_shop_path(current_user.shops.first)
      return
    end
    # Let's anticipate on next week (with login)
    @shops = current_user.shops
  end

  def show
    @shop = Shop.find(params[:id])
  end
end

