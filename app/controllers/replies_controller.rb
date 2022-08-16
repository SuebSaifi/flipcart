class RepliesController < ApplicationController
    before_action :set_product,:set_reply,:set_review,only:[:new]
    def new 
        @review=Review.find(params[:review_id])
        @reply = @review.replies.new(parent_id: params[:parent_id])
    end
    def create
    @review=Review.find(params[:review_id])
        @reply = @review.replies.build(reply_params)
            if @reply.save
            redirect_to @product
        end
    end
    def destroy
        @reply = Reply.find(params[:id])
        @reply.destroy
        respond_to do |format|
            format.html { redirect_to @product    }
            format.json { head :no_content }
            format.js   { render :layout => false }
        end
  end
    private
    def set_product
        @product=Product.find(params[:product_id])
    end
    def set_review
        @review=Review.find(params[:review_id])
    end
    def set_reply
        @reply=Reply.find(params[:reply_id])
    end
    def reply_params
        params.require(:reply).permit(:user_id,:review_id,:reply,:parent_id)
    end
end
