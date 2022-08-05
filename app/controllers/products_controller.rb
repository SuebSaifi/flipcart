class ProductsController < ApplicationController
before_action :set_product, only: %i[ show edit update destroy ]
  def index
    @products = Product.paginate(page: params[:page], per_page: 4)
  end
  
  def new
    @product = current_user.products.build
  end
  def edit
    
  end
   def show 
      @product=Product.find(params[:id])   
  end
  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product successfully Added"
      redirect_to @product
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  
  def update 
    
  end
    def destroy
      @product.destroy
    end
  private
  def set_product
    @product = Product.find(params[:id])
  end
  
  def product_params
    params.require(:product).permit(:title,:price,:description,:image,:user_id,:category_id,:brand_id)
  end
  
end
