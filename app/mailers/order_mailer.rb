class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.update.subject
  #
  # def update
  #   @greeting = "Hi"

  #   mail to: "to@example.org"
  # end

  def register(order)
    @order = order
    @user = @order.user

    mail(to: @user.email, subject: 'Vous avez passé commande !')
  end

  def ready(order)
    @order = order
    @user = @order.user  # Instance variable => available in view

    mail(to: @user.email, subject: 'Votre commande est prête !')
    # This will render a view in `app/views/user_mailer`!
  end

  def canceled(order)
    @order = order
    @user = @order.user  # Instance variable => available in view

    mail(to: @user.email, subject: 'Votre commande a été annulée !')
  end


end


