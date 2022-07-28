class ChargesController < ApplicationController
    def index
        @charges=Charge.all
    end
    def show
        @charge=Charge.find(prarams[:id])
    end
    def new
        session[:charge_params] ||= {}
        @charge  = Charge.new(session[:charge_params])    
        @charge.current_step=session[:charge_steps]
    end
    def create
        session[:charge_params].deep_merge!(params[:charge_params]) if params[:charge_params]
        @charge  = Charge.new(session[:charge_params])    
        @charge.current_step=session[:charge_steps]
        
        if params[:back_btn]
            @charge.pervious_step
        elsif @charge.last_step?
            @charge.save
            session[:charge_params]=nil
            redirect_to charges_path
        else
            @charge.next_step
        end
        session[:charge_steps]=@charge.current_step
        # render "new"
    end
    private
    def charge_params
        params.require(:charge).permit(:user_id,:order_id)
    end
    
end