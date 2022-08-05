class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
    @products=Product.all
  end

  def new
    @review =current_user.reviews.build
    respond_to do  |format|
      format.js
    end
  end

  def show
    @review = Review.find(params[:id])
  end
  def edit
    @review=Review.find(params[:id])  
  end
  def create
    @product=Product.find(params[:product_id])
    @review = @product.reviews.build(reviews_params)
    respond_to  do |format|
    if @review.save
      format.html{redirect_to @product}
      format.js
     
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  end
  
  def update
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    respond_to do |format|
        format.html { redirect_to @product    }
        format.json { head :no_content }
        format.js   { render :layout => false }
     end
  end

  private
    def reviews_params
      params.require(:review).permit(:review,:user_id)
    end
end
