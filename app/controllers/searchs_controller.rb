class SearchsController < ApplicationController
    # Search_Per_page = 2
    def index 
        #@page = params.fetch(:page,0).to_i
        #searchcount = Product.where("title LIKE ?","#{params[:search]}%").count#.offset(@page*Search_Per_page).limit(Search_Per_page)
        @searchproducts = Product.all
        if params[:filter].present?
            @searchproducts= @searchproducts.where(brand_id: filter_params[:brand_id]) if filter_params[:brand_id] 
            @searchproducts= @searchproducts.where(category_id: filter_params[:category_id]) if filter_params[:category_id].present?
            @searchproducts= @searchproducts.where(price: (filter_params[:min]..filter_params[:max])) if (filter_params[:min] || filter_params[:max]).present?
            @searchproducts= @searchproducts.where("title LIKE ?","#{params[:query]}%") if params[:query].present?
        end
        @searchproducts = @searchproducts.paginate(page: params[:page], per_page: 3)
        render 'index'
    end
    
    private
    
    def filter_params
    debugger
        params.require(:filter).permit(:brand_id, :category_id, :min, :max, :query)
    end
end
