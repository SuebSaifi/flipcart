class OrdersController < ApplicationController
  def index
      @orders = Order.where(:is_paid=>true)
  end
  
  def show
    @order = Order.find(params[:id])
  end
  def new
    session[:order_params]||={}
    @order =Order.new(session[:order_params])
    @order.current_step=session[:order_steps]
  end
  def create
    session[:order_params].deep_merge!(user_params) if params[:order]  
    @order =Order.new(session[:order_params])
    @order.current_step=session[:order_steps]
    if params[:back_btn]
        @order.pervious_step
    elsif @order.last_step?
        @current_cart.line_items.each do |item|
            @order.line_items << item
            item.update(cart_id: nil)
        end
        @order.save
        OrderMailer.order_created(@order).deliver_now!
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
    else
        @order.next_step
    end
        session[:order_steps]=@order.current_step       
    if @order.new_record?
        render "new"
    else
        session[:order_params] = nil
        session[:order_steps]=@order.first_step
        flash[:notice] = "Order saved!"
        redirect_to @order
    end
  end
  private
    def user_params
        params.require(:order).permit(:name,:email,:phone_number,:address, :state , :pincode,:user_id)
    end
end
