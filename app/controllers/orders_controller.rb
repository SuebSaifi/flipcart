class OrdersController < ApplicationController
    def index
        @orders=Order.all        
    end
    def new 
        @order=Order.new
    end
    def create 
        @cart=Cart.find(params[:id])
        @order = current_user.order.build(order_params)
        current_user.carts.each do |item|
          item
        end
        @order.save
        OrderMailer.with(user: current_user,order:@order).order_created.deliver_later
        redirect_to user_orders_path
    end
    private
    
def order_params
    params.require(:order).permit(:email,:name ,:address,:cart_id)
end
end
