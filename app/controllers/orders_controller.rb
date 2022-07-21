class OrdersController < ApplicationController
    def index
        @orders=Order.all        
    end
    def new 
        @order=current_user.orders.build
    end
    def create 
        @order=current_user.orders.create(cart_id: params[cart_id])
        if @order.save
            flash[:notice]="Odered Successfully"
            redirect_to user_orders_path
        end
    end
end
