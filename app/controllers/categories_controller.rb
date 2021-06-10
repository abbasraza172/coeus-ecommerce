class CategoriesController < ApplicationController
  before_action :set_category, only: [ :edit, :update, :destroy]
  layout 'seller-layout', only: [:index, :create, :new, :edit]
  
  def index
      @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category successfully created.'
      redirect_to seller_path
    else
      render :new
    end
  end

  def update
    @category.update(category_params)
    redirect_to categories_path
  end

  def destroy
    @catgory.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :status)
  end

  def set_category
    @category = Category.find(params[:id])
  end
  
end
