class SellerProductsController < ApplicationController
  layout 'seller-layout', only: [:index, :show, :create, :new, :edit]
  before_action :authenticate_user!, :validate_domain
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in?
      if current_user.admin?
        @products =Product.all.page(params[:page]).per_page(7)
      else  
        @products =current_user.business.products.page(params[:page]).per_page(7) rescue []
      end
    else
      redirect_to new_user_session_path
    end
  end
  
  def new
    @product = Product.new
    @product.pictures.build
  end

  def show
    @product_feedbacks = current_user.business.product.feedbacks rescue []
    @current_product_pictures = @product.pictures rescue []
    @display_picture = @product.pictures.last.image_url rescue ""
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
