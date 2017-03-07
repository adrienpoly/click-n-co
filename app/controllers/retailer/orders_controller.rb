class Retailer::OrdersController < ApplicationController

  def index
  end

  def show
    # @tab_status = ["en attente", "en cours de_préparation", "commande_prête", "commande_récupérée", "commande_annulée"]
    @tab_status = {
      "en_attente" => "en attente",
      "en_cours_de_préparation" => "en cours de préparation",
      "commande_prête" => "commande prête",
      "commande_récupérée" => "commande récupérée",
      "commande_annulée" => "commande annulée"}

    @order = Order.find(params[:id])
    @shop = Shop.find(params[:shop_id])
    @nbr_circles = @tab_status[@order.status]
    #@orders = @shop.orders
    #@orders = @shop.orders
  end

end

