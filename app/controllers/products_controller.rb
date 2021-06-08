class ProductsController < ApplicationController
  layout "default_layout"
  before_action :set_categories

  def index
    @category = Category.find_by(id: params[:category_id])
    @products = []
    if @category
      @products = @category.products
    else
      redirect_to index_path
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil? || @product.status == false
      flash.now[:alert] = "Product was not found"
      redirect_to index_path
    end
  end

  def list_view
    @products = Product.order(created_at: "DESC")
  end

  def grid_view
    @products = Product.order(created_at: "DESC")
  end

  def set_categories
    @categories = Category.where(status: true).order(name: "ASC")
  end
end
