class ShopsController < ApplicationController
  before_action :find_shop, only: [:show]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @shops = Shop.all
    # @shops = Shop.near(params['where'], 1000)
    @hash = Gmaps4rails.build_markers(@shops) do |shop, marker|
      marker.lat shop.latitude
      marker.lng shop.longitude
      marker.infowindow render_to_string(partial: "/shared/map_box", locals: { shop: shop })
    end
    find_relative_distances(params['where'])
  end

  def show
  end


  private

  def find_shop
    @shop = Shop.find(params[:id])
  end

  def find_relative_distances(centre)
    location = Geocoder.coordinates(centre)
    if location
      @shops.each do |shop|
        shop.distance = Geocoder::Calculations.distance_between(location, [shop.latitude, shop.longitude]).truncate
      end
    end
  end
end
