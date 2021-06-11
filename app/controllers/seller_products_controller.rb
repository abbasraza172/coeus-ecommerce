class SellerProductsController < ApplicationController
    before_action :authenticate_user!, :validate_domain
    before_action :set_product, only: [ :edit, :update, :destroy]
    layout 'seller-layout', only: [:index, :create, :new, :edit]
    def index
      if user_signed_in?
        if current_user.admin?
          @products =Product.all
        else  
          @products =current_user.business.products rescue []
        end
      else
        redirect_to new_user_session_path
      end
    end
    
    def new
      @product = Product.new
      @product.pictures.build
    end
    
    def create
      @product = Product.new(product_params)
      @product.business_id = current_user.business_id
      if @product.save
        flash[:notice] = 'product successfully created.'
        redirect_to seller_products_path
      else
        render :new
      end
    end
    
    def update
      @product.update(product_params)
      redirect_to seller_products_path
    end
    
    def destroy
      @product.destroy
      redirect_to seller_products_path
    end
    
    private
    
    def product_params
      params.require(:product).permit(:name, :description, :current_price, :quantity, :status, pictures_attributes: [:image],:category_ids => [])
    end
    
    def set_product
      @product = Product.find(params[:id])
    end
        
end
