class RatingsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @product=Product.find(params[:product_id])
    @rating = @product.ratings.build(rating_params)
    if @rating.save
      
      redirect_to @product
    end
  end
  private 
    def rating_params
      params.require(:rating).permit(:rating,:user_id)  
    end
    
end
