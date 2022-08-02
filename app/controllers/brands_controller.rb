class BrandsController < ApplicationController
    def show
        @brand=Brand.find(params[:id])
        @products = @brand.products.all
    end
end