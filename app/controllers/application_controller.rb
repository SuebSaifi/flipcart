class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :current_cart
  before_action :current_order
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
    
    def current_order
      if session[:order_id]
        order=Order.find_by(:id=>session[:order_id])
        if order.present?
            @current_order = order
          end
        else
          session[:order_id] = nil
        end
        
        if session[:order_id] == nil
          @current_order = Order.new
          @current_cart.line_items.each do |item|
            @current_order.line_items.push(item)
            # item.update(cart_id: nil)
            end
        end
    end
end
