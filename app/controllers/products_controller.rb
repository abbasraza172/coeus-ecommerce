class ProductsController < ApplicationController
    layout 'default_layout'
    
    def index
        redirect_to index_path
    end

    def show
        @categories = Category.where(status: true).order(name: "ASC")
        @product = Product.find_by(id: params[:id])
        if @product.nil? || @product.status == false
           flash.now[:alert] = "Product was not found"
           redirect_to index_path
        end
        # @related_products = 
    end
end
