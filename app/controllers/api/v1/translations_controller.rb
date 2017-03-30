class Api::V1::TranslationsController < Api::V1::BaseController
  def new
    @response = { argomuch: "" }
    @response[:argomuch] = Louch.translate(params[:sentence]) if params[:sentence]
  end

  def translate
    # byebug
    @response = { argomuch: "" }
    @response[:argomuch] = Louch.translate(params[:sentence]) if params[:sentence]
    render json: @response
  end

  def dictionnary
    @words = Louch.dictionnary
    # render json: Louch.dictionnary
  end
end


