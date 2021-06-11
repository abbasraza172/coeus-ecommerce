class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]
  layout "seller-layout", only: [:index, :show, :create, :new, :edit]

  def index
    if (params[:type])
      @orders = current_user.business.orders.where(status: params[:type]) rescue []
      @delivered = current_user.business.orders.where(status: params[:type]) rescue []
      @pending = current_user.business.orders.where(status: params[:type]) rescue []
    else
      @orders = current_user.business.orders rescue []
    end
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    cart_products = JSON.parse(params[:product_details])
    unless cart_products.empty?
      @order = Order.new
      @order.delivery_address = params[:delivery_address]
      @order.user_id = current_user.id
      @order.total_bill = params[:total_bill].to_f

      if @order.save
        cart_products.each do |cart_product|
          order_product = @order.order_products.new
          order_product.product_id = cart_product["id"]
          order_product.quantity = cart_product["qty"]
          order_product.price = cart_product["price"]
          order_product.save
        end
        flash[:notice] = "order successfully created."
        redirect_to index_path
      else
        render :new
      end
    end

  def update
    @order.update(order_status_params)
    redirect_to orders_path
  end
        
  def destroy
    @order.destroy
    redirect_to orders_path
  end

  private

  def order_status_params
    params.require(:order).permit(:status)
  end

  def order_params
      params.require(:order).permit(:delivery_address, :total_bill, :user_id)
    end

  def set_order
    @order = current_user.orders.find(params[:id]) rescue []
  end
end
