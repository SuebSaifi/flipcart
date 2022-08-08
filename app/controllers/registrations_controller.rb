class RegistrationsController < Devise::RegistrationsController
    def index 
        @users=User.all
    end
    
    def show
        @user=User.find(params[:id])
    end
    
    def new
    # debugger
        session[:user_params]||={}
        @user =User.new(session[:user_params])
        @user.current_step=session[:user_steps]
    end
    
    def create
        session[:user_params].deep_merge!(sign_up_params) if params[:user]       
        @user =User.new(session[:user_params])
        @user.current_step=session[:user_steps]
        if @user.valid?
            if params[:back_btn]
                @user.pervious_step
            elsif @user.second_step?
                @user.update(sign_update_params)                   
            elsif @user.last_step?
                @user.save
            else
                @user.next_step
            end
        end
        session[:user_steps]=@user.current_step
        if @user.new_record?
            render 'new'        
        else
            session[:user_step] = session[:user_params] = nil
            flash[:notice] = "User Has been successfully sign up"
            redirect_to new_user_session_path
        end
    end
    private
    def sign_up_params
        params.require(:user).permit(:first_name,:last_name,:email,:phone_number,:admin,:line_address,:state,:pincode,:password,:password_confirmation)
    end
    def sign_update_params
        params.require(:user).permit(:saller,:buyer,:avatar)
    end
    def account_update_params 
        params.require(:user).permit(:first_name,:last_name,:email,:phone_number,:avatar,:password,:password_confirmation,:current_password)
    end
    end