class OrderMailerPreview < ActionMailer::Preview

  def ready
    @order = order
    user = @order.user
    UserMailer.ready(user)
  end

  def canceled
    @order = order
    user = @order.user
    UserMailer.cancel(user)
  end
end
