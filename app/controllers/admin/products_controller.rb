class Admin::ProductsController < ApplicationController
    before_action :authenticate_admin!
    
    def index
      @products = Product.all
    end
    
    def new
      @product = Product.new
    end
    def edit
      @product = Product.find(params[:id])
    end
     def show 
        @product=Product.find(params[:id])   
    end
    def create
      @product = Product.new(product_params)
      if @product.save
        @category_arr=params.dig(:product,:category_ids)
        @category_arr.each do |cat|
          @category = Category.find(cat)
          @product.categories.push(@category)
        end
        flash[:success] = "Object successfully created"
        redirect_to admin_products_path
      else
        flash[:error] = "Something went wrong"
        render 'new'
      end
    end
    
    def update 
      @product = Product.find(params[:id])
      if @product.update(product_params)
        @product.product_categories.destroy_all
        @category_arr=params.dig(:product,:category_ids)
        @category_arr.each do |cat|
          @category = Category.find(cat)
          @product.categories << @category
        end
        flash[:success] = "Object successfully created"
        redirect_to admin_products_path
      else
        flash[:error] = "Something went wrong"
        render :edit
      end
    end
    def destroy
      @product.destroy
      flash[:notice]="product removed!"
      redirect_to admin_products_path
    end
    private
    def set_product
      @product = Product.find(params[:id])
    end
    
    def product_params
      params.require(:product).permit(:title,:price,:description,:image)
    end
    
  end
  