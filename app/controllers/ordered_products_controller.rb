class OrderedProductsController < ApplicationController
  def index
    @ordered_products = OrderedProduct.all
  end

  def add
    session[:cart] = {} unless session[:cart]
    # cart is a hash : primary key is the shop_id (assuming they could be multiple shops in the order
    # in a key shop_id there are several hash with product id as the main key
    @cart = session[:cart]
    @cart[params[:shop_id]] = {} unless @cart[params[:shop_id]]

    if @cart[params[:shop_id]][params[:id]]
      @cart[params[:shop_id]][params[:id]]['qty'] += 1
    else
      product = Product.find(params[:id].to_i)
      @cart[params[:shop_id]][params[:id]] = { name: product.name, price: product.price, qty: 1 }
    end
    redirect_to shop_path(params[:shop_id])
  end

  def remove
    session[:cart][params[:shop_id]].delete(params[:id])
    redirect_to shop_path(params[:shop_id])
  end

  def reduce
    # product = Product.find(params[:id].to_i)
    @cart = session[:cart][params[:shop_id]] || {} #set to empty hash if empty (new cart)
    if session[:cart][params[:shop_id]][params[:id]]
      if session[:cart][params[:shop_id]][params[:id]]['qty'] > 1
        session[:cart][params[:shop_id]][params[:id]]['qty'] -= 1
      else
        session[:cart][params[:shop_id]].delete(params[:id])
      end
    end
    redirect_to shop_path(params[:shop_id])
  end
end
