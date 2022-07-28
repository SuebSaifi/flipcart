class CheckoutController < ApplicationController
    def create
      # product=Product.find(params[:id])
      # debugger
      @session = Stripe::Checkout::Session.create({
       customer: current_user.stripe_customer_id,
       payment_method_types: ['card'],
       shipping_address_collection: {
        allowed_countries: ['IN'],
      },
      shipping_options: [
        {
          shipping_rate_data: {
            type: 'fixed_amount',
            fixed_amount: {
              amount: 0,
              currency: 'inr',
            },
            display_name: 'Free shipping',
            # Delivers between 5-7 business days
            delivery_estimate: {
              minimum: {
                unit: 'business_day',
                value: 5,
              },
              maximum: {
                unit: 'business_day',
                value: 7,
              },
            }
          }
        },
        {
          shipping_rate_data: {
            type: 'fixed_amount',
            fixed_amount: {
              amount: 1500,
              currency: 'inr',
            },
            display_name: 'Next day air',
            # Delivers in exactly 1 business day
            delivery_estimate: {
              minimum: {
                unit: 'business_day',
                value: 1,
              },
              maximum: {
                unit: 'business_day',
                value: 1,
              },
            }
          }
        },
      ],
      line_items: [Order.last.line_items.collect{|i|i.to_builder.attributes!}],
        mode: 'payment',
        success_url:orders_url,
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
