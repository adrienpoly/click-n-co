class Retailer::ShopsController < ApplicationController
  def index

    if current_user.shops.one?
      redirect_to retailer_shop_path(current_user.shops.first)
      return
    end
    # Let's anticipate on next week (with login)
    @shops = current_user.shops
    # @shop = current_user.shops.find(params[:id])
  end

  def show
    @shop = Shop.find(params[:id])
    @orders = @shop.orders
    @orders_in  = @orders.where("pick_up_at > ?", Date.today )
    @orders_out = @orders.where("pick_up_at < ?", Date.today )
  end

end




