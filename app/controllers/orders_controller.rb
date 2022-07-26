class OrdersController < ApplicationController

    def index
        @orders=Order.all     
        @products=Product.all
    end
    def new 
        @order=Order.new
    end
    def create 
        # debugger    
        @product=Product.find_by(params[:id])   
        @order = @product.orders.new(order_params)
        if @order.save
        OrderMailer.with(user: current_user,order:@order).order_created.deliver_later
            redirect_to user_orders_path
        else
        render "new"
        end
    end
    private

    def order_params
    params.require(:order).permit(:user_id,:email,:name ,:address,:product_id)
end
end
