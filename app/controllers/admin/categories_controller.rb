class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @categories=Category.all

  end
  def new
    @category=Category.new
  end
  def create
    @category=Category.new(catagory_params)
    if @category.save
        flash[:notice]="Catagory create"
        redirect_to admin_categories_path
    else
        flash[:error] = "Something went wrong"
        render 'new'
    end
  end
  def edit
    @category =Catagory.find(params[:id])
  end
  def update
    @category=Catagory.find(params[:id])
    if @category.update(catagory_params)
        flash[:notice]="Catagory Updated"
        redirect_to admin_categories_path
    else
        flash[:error] = "Something went wrong"
        render :edit
    end
  end
  def destroy 
    Catagory.destroy(params[:id])
    flash[:notice]="Category removed!"
      redirect_to admin_products_path
  end
private
def catagory_params
    params.require(:category).permit(:name)
end

end
