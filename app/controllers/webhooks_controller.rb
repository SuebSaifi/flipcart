class WebhooksController < ApplicationController
    skip_before_action :authenticate_user!, raise: false
    skip_before_action :verify_authenticity_token, raise: false
    def create
    
        payload = request.body.read
        sig_header = request.env['HTTP_STRIPE_SIGNATURE']
        event = nil
    
        begin
        event = Stripe::Webhook.construct_event(
          payload, sig_header,  'whsec_655b854df1422e4ab5cd910dc2e4f5c830cb4a1c7acda74a641198efc8cd7bbb'
        )
        rescue JSON::ParserError => e
          status 400
            return
        rescue Stripe::SignatureVerificationError => e
          puts "Signature error"
          p e
          return
        end
        debugger
        case event.type
        when 'checkout.session.completed'
          session = event.data.object
          order = Order.find_by(id: session.metadata.id)
          order.update(is_paid: true) 
          OrderMailer.with(user: current_user,order:@order).order_created.deliver_later
        end    
        render json: { message: 'success' } 
      end
end