class OrderedProductsController < ApplicationController
  def index
    @ordered_products = OrderedProduct.all
  end

  def add
    session[:cart] = {} unless session[:cart]
    if session[:cart][params[:id]]
      session[:cart][params[:id]]['qty'] += 1
    else
      product = Product.find(params[:id].to_i)
      session[:cart][params[:id]] = { name: product.name, price: product.price, qty: 1 }
    end
    redirect_to shop_path(params[:shop_id])
  end

  def remove
    session[:cart].delete(params[:id])
    redirect_to shop_path(params[:shop_id])
  end

  def reduce
    # product = Product.find(params[:id].to_i)
    if session[:cart][params[:id]]
      if session[:cart][params[:id]]['qty'] > 1
        session[:cart][params[:id]]['qty'] -= 1
      else
        session[:cart].delete(params[:id])
      end
    end
    redirect_to shop_path(params[:shop_id])
  end
end
