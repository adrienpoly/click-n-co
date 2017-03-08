class PaymentsController < ApplicationController
  before_action :set_order, only: [:new]

  def new
    @sum = 0
    @table.each do |partial|
      @sum += partial.total_price
    end
    @order = @table.last
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail])

    params[:my_cart].split.each do |id|
      @order = Order.find(id)
      #@order = Order.where(status: :pending).find(params[:order_id])
      charge = Stripe::Charge.create(
      customer:    customer.id,   # You should store this customer id and re-use it.
      amount:      @order.total_price_cents, # or amount_pennies
      description: "Payment for Click-n-co #{@order.shop.name} for order #{@order.id}",
      currency:    @order.total_price.currency)
      @order.update(payment: charge.to_json, status: :confirmed)
      OrderMailer.register(@order).deliver_now
    end
    redirect_to orders_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_order_payment_path(@order)
  end

  private

  def set_order
    @table = []
    params[:my_cart].each do |id|
      @table << Order.find(id)
    end
    # @order = Order.where(status: :pending).find(params[:order_id])
  end
end
