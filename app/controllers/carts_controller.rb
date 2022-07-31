class CartsController < ApplicationController
    def create 
      chosen_cart = Cart.find(params[:cart_id])
      current_order = @current_order
    end
    def show
        @cart = @current_cart
      end
    
      def destroy
        @cart = @current_cart
        @cart.destroy
        session[:cart_id] = nil
        redirect_to root_path
      end
end
