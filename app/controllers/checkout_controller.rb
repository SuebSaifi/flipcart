class CheckoutController < ApplicationController
    def create
      # debugger
      @order=Order.find(params[:id])
      @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      payment_method_types: ['card'],
      line_items: [@order.line_items.collect{|i|i.to_builder.attributes!}],
      mode: 'payment',
      success_url:orders_url,
      cancel_url: root_url,
    })  
      respond_to do |format|
        format.js
      end
  end
end
