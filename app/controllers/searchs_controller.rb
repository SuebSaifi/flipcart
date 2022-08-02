class SearchsController < ApplicationController
    Search_Per_page = 2
    def index 
        @page = params.fetch(:page,0).to_i
        # debugger
        @searchcount = Product.where("title LIKE ?","#{params[:search]}%").count
        @searchproducts = Product.where("title LIKE ?","#{params[:search]}%").offset(@page*Search_Per_page).limit(Search_Per_page)
    end
    def last 
        @searchcount.last-1
    end
    def first 
        @searchcount.first
    end
end
