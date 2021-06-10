class HomeController < ApplicationController
  layout "default_layout"
  

  def index
    @categories = Category.where(status: true).order(name: "ASC")
    @new_products = Product.order(created_at: "DESC").limit(6)
    @popular_products = Product.all
    @featured_products = Product.all
  end

  def main
    if @sub_domain == "buyer"
      redirect_to index_path
    elsif @sub_domain == "seller"
      redirect_to seller_path
    elsif @sub_domain == "admin"
      redirect_to admin_path
    else
      redirect_to index_path
    end
  end

  def cart
  end

  def next
  end
end
