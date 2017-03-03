class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @categories = Category.all.order('name')
    @coordinates = cookies[:lat_lng].split("|") if cookies[:lat_lng]
  end


end
