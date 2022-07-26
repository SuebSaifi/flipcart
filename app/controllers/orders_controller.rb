class OrdersController < ApplicationController

    def index
        @orders=Order.all     
        @products=Product.all
    end
    def new 
        @order=Order.new
    end
    def create
        @order = Order.new(order_params)
        @current_cart.line_items.each do |item|
          @order.line_items.push(item)
          item.cart_id = nil
        end
        if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        redirect_to orders_path
        else
            render 'new'
        end
      end
      
    private

    def order_params
    params.require(:order).permit(:email,:name ,:address)
end
end
