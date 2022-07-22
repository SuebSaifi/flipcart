class CartsController < ApplicationController
    def index
        @carts=current_user.carts.all
    end
 

    def create
        @cart =Cart.create!(product_id: params[:product_id],user_id: current_user.id)        
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
