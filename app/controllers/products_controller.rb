class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :search ]

  def index
    session[:address] = "bordeaux" if session[:address].blank?
    @shops = Shop.near(session[:address],5).limit(4).offset(1)
    @today = Date.today
    @open_hours = OpeningHour.where(shop_id: params[:id])
    @collection = OpenHourSort.new(@open_hours).call  ## unless @open_hours.empty?
    @cart = session[:cart] || {} #set to empty hash if empty (new cart)
    @product_hash = Product.search(params[:search], session[:address])
  end

  def search
    @products = Product.search_autocomplete(params[:term])
  end
end
