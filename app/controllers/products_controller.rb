class ProductsController < ApplicationController
    before_action :set_product, only: [ :edit, :update, :destroy]
    layout 'seller-layout', only: [:index, :create, :new, :edit]
    def index
        @products = Product.all
    end
    
    def new
      @product = Product.new
    end
    
    def create
      @product = Product.new(product_params)
      @product.user_id = 1
      if @product.save
        flash[:notice] = 'product successfully created.'
        redirect_to products_path
      else
        render :new
      end
    end
    
    def update
      @product.update(product_params)
      redirect_to products_path
    end
    
    def destroy
      @product.destroy
      redirect_to products_path
    end
    
    private
    
    def product_params
      params.require(:product).permit(:name, :description, :current_price, :quantity, :status, :user_id, :category_ids => [])
    end
    
    def set_product
      @product = Product.find(params[:id])
    end
    
end
