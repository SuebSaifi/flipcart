class CheckoutController < ApplicationController
    def create
      # product=Product.find(params[:id])
      # debugger
      @session = Stripe::Checkout::Session.create({
        customer: current_user.stripe_customer_id,
       payment_method_types: ['card'],
       
        line_items: [@current_cart.line_items.collect{|i|i.to_builder.attributes!}
      ],
        mode: 'payment',
        success_url: root_url,
        cancel_url: root_url,
      })
      respond_to do |format|
        format.js
      end
  end

  def success 
      @current_cart.destroy
      Cart.destroy(session[:cart_id])
      @session_with_expand =Stripe::Checkout::Session.retrieve({id:params[:session_id],expand:['line_items']})
      @session_with_expand.line_items.data.each do |line_item|
      product = Product.find_by(stripe_product_id: line_item.price.product)
    end
    end

end
