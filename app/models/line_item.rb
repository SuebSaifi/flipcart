class LineItem < ApplicationRecord
    belongs_to :product
    belongs_to :cart
    belongs_to :order
  
    # LOGIC
    def total_price
      self.quantity * self.product.price
    end
  end
  def add_quantity
  @line_item = LineItem.find(params[:id])
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
