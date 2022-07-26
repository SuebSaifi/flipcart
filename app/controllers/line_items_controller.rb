class LineItemsController < ApplicationController
  def create
    chosen_product = Product.find(params[:product_id])
    current_cart = @current_cart
  
    if current_cart.products.include?(chosen_product)
      @line_item = current_cart.line_items.find_by(:product_id => chosen_product)
      @line_item.quantity += 1
    else
      # debugger
      @line_item = LineItem.new
      @line_item.cart_id = current_cart.id
      @line_item.product = chosen_product
    end
    # debugger
    @line_item.save
    respond_to do |format|
      format.js
    end
  end
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to cart_path(@current_cart)
  end  
  def add_quantity
    @line_item = LineItem.find(params[:id])
    # debugger
    @line_item.quantity += 1
    @line_item.save
    redirect_to cart_path(@current_cart)
  end
  
  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity > 1
      @line_item.quantity -= 1
    end
    @line_item.save
    redirect_to cart_path(@current_cart)
  end
end
