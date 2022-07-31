class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_created.subject
  #
  def order_created
    
    @order=params[:order]
    @user=params[:user]
    @greeting ="Hi"
    
    mail to: @user.email,subject: "New Order created" 
  end
end
