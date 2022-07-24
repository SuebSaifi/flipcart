class ProductsController < ApplicationController
before_action :set_product, only: %i[ show edit update destroy ]
  def index
    @products = Product.all
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
      @category_array = params.dig(:product,:categories_ids)
      @category_array.each do |cat|
        @caregory=Category.find(cat)
        @product.categories << @caregory
      end
      flash[:success] = "Object successfully created"
      redirect_to @product
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  
  def update 
    
  end
  
  private
  def set_product
    @product = Product.find(params[:id])
  end
  
  def product_params
    params.require(:product).permit(:title,:price,:description,:image)
  end
  
end
