class CheckoutController < ApplicationController
    def create
      # debugger
      @order=Order.find(params[:id])
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
