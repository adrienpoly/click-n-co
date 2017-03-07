class PaymentsController < ApplicationController
  before_action :set_order

  def new
  end

  def create
    customer = Stripe::Customer.create(
    source: params[:stripeToken],
    email:  params[:stripeEmail])

    charge = Stripe::Charge.create(
    customer:    customer.id,   # You should store this customer id and re-use it.
    amount:      @order.total_price_cents, # or amount_pennies
    description: "Payment for Click-n-co #{@order.shop.name} for order #{@order.id}",
    currency:    @order.total_price.currency)

    @order.update(payment: charge.to_json, status: :confirmed)
    OrderMailer.register(@order).deliver_now

    redirect_to orders_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_order_payment_path(@order)
  end

  private

  def set_order
    @order = Order.where(status: :pending).find(params[:order_id])
  end
end
