class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :current_cart

    private
      def current_cart
        # debugger
        if session[:cart_id]
          cart = Cart.find_by(:id => session[:cart_id])
          if cart.present?
            @current_cart = cart
          else
            session[:cart_id] = nil
          end
        end
  
        if session[:cart_id] == nil
          @current_cart = Cart.create
          if @current_cart.save
           session[:cart_id] = @current_cart.id
          end
        end
      end
end
