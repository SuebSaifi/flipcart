class OrdersController < ApplicationController
    def index
        @orders = Order.all
      end
    
      def show
        @order = Order.find(params[:id])
      end
    
      def new
        @order = Order.new
      end
    def create
        @order = Order.new(order_params)
        @current_cart.line_items.each do |item|
          @order.line_items.push(item)
          item.update(cart_id: nil)
        end
        @order.save
        OrderMailer.with(user: current_user).order_created.deliver_later
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        redirect_to orders_path
      end
      
    private

    def order_params
    params.require(:order).permit(:email,:name ,:address)
end
end
