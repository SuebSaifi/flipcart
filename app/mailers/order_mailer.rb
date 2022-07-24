class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_created.subject
  #
  def order_created
    @greeting = "Hi"
    @order=params[:order]
    mail to: "to@example.org"
  end
end
