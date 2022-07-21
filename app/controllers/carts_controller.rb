class CartsController < ApplicationController
    def index
        @carts=Cart.all
    end
 
    def new
        @cart = current_user.carts.build
    end
    
    def create
        @cart = current_user.carts.build(product_id: params[:product_id])
        if @cart.save 
        flash[:notice]="Added to Cart Successfully"
            redirect_to user_carts_path
        end
    end
    def edit
        
    end
    def update 
                
    end
    def destroy
        @cart=Cart.find(params[:id])
        if @cart.destroy
            flash[:notice]="Item has been successfully remove"
            redirect_to user_carts_path
        end        
    end
end
