class HomeController < ApplicationController
    layout 'default_layout'
    
    def index
        @categories = Category.where(status: true).order(name: "ASC")
        @new_products = Product.order(created_at: "DESC").limit(6)
        @popular_products = Product.all
        @featured_products = Product.all
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

    def main
        if @sub_domain == "buyer"
            redirect_to index_path
        else
            redirect_to home_next_path
        end   
    end

    def next     
    end
end
