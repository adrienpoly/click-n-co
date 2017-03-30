class Api::V1::ShopsController < Api::V1::BaseController
  def search
    @shops = Shop.search_by_latlng(params)
    # render json: @shops
  end
end


