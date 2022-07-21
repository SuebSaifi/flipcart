class WishlistsController < ApplicationController
    
    before_action :set_product,only: :toggle
    before_action :find_wishlist ,only: :destroy
    def index 
        @wishlists=Wishlist.all
    end
    
    def toggle
        if already_wishlisted?
            # flash[:notice]="You canot wishlist"   
            # debugger
            @wishlist=@product.wishlists.find(params[:id])
            @wishlist.destroy
            respond_to do |format| 
                format.html
                format.js
            end
        else
            @wishlist = Wishlist.create(product_id: params[:product_id] ,user_id: current_user.id)
            if @wishlist.save
                respond_to do |format| 
                    format.html 
                    format.js  
                end
            end
        end  
    end      
    private
    
    def set_product
        @product=Product.find(params[:product_id])
    end
    def find_wishlist
        @wishlist=@product.wishlists.find(params[:id])
    end
    
    def already_wishlisted?
        Wishlist.where(user_id:current_user.id,product_id:params[:product_id]).exists?    
    end

end



