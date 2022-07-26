class CheckoutController < ApplicationController
    def create
      product=Product.find(params[:id])
      # debugger
      @session = Stripe::Checkout::Session.create({
       payment_method_types: ['card'],
        line_items: [{
          name: product.title,
          amount: product.price.to_i*100,
          currency: "inr",
          quantity: 1
        }],
        mode: 'payment',
        success_url: orders_url,
        cancel_url: root_url,
      })
      respond_to do |format|
        format.js
      end
  end

  def success 
    @session_with_expand =Stripe::Checkout::Session.retrieve({id:params[:session_id],expand:['line_items']})
    @session_with_expand.line_items.data.each do |line_item|
      product = Product.find_by(stripe_product_id: line_item.price.product)
    end
    end

end
