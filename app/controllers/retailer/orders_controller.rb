class Retailer::OrdersController < ApplicationController

  def index
  end

  def show
    # @tab_status = ["en attente", "en cours de_préparation", "commande_prête", "commande_récupérée", "commande_annulée"]
    @tab_status = {
      "pending" => "en attente",
      "processing" => "en cours de préparation",
      "confirmed" => "confirmé",
      "ready" => "commande prête",
      "picked_up" => "commande récupérée",
      "canceled" => "commande annulée"}

    @order = Order.find(params[:id])
    @shop = Shop.find(params[:shop_id])
    @nbr_circles = @tab_status[@order.status]
    #@orders = @shop.orders
    #@orders = @shop.orders
  end

end

