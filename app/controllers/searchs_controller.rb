class SearchsController < ApplicationController
    def index 
        @products = Product.where("title LIKE ?","#{params[:search]}%")
    end
end
