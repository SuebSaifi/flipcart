class WebhooksController < ApplicationController
    skip_before_action :authenticate_user!, raise: false
    skip_before_action :verify_authenticity_token, raise: false
    endpoint_secret = 'whsec_655b854df1422e4ab5cd910dc2e4f5c830cb4a1c7acda74a641198efc8cd7bbb'
    set :port, 3000
    def create
        payload = request.body.read
        sig_header = request.env['HTTP_STRIPE_SIGNATURE']
        event = nil
    
        begin
        event = Stripe::Webhook.construct_event(
          payload, sig_header,  endpoint_secret
        )
        rescue JSON::ParserError => e
          status 400
        return
        rescue Stripe::SignatureVerificationError => e
          puts "Signature error"
          p e
          return
        end

        case event.type
        
        when 'checkout.session.succeeded'
          checkout = event.data.object
          fullfilorder(checkout)
        end
    
        render json: { message: 'success' }
      end
    def fullfilorder(checkout)
        order = Order.find_by(params[:id])
        order.update(is_paid: true) 
    end
end