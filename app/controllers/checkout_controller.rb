class CheckoutController < ApplicationController
    def create
      product=Product.find(params[:id])
      session = Stripe.Checkout.Session.create({
       payment_method_types: ['card'],
        line_items: [{
            name: product.title,
            amount: product.price.to_i,
            currency: "inr",
            quantity: 1
    }

        ],
        mode: 'payment',
        success_url: root_path,
        cancel_url: root_path,
      })
          respond_to do |format|
            format.js
          end
          
    end
end
