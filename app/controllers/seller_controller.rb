class SellerController < ApplicationController
  layout 'seller-layout'
  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    elsif !current_user.business_id.nil?
      @orders= current_user.business.orders
      @delivered_orders = current_user.business.orders.where(status: "delivered").count rescue []
      @pending_orders = current_user.business.orders.where(status: "pending").count rescue []
      @total_cash = current_user.business.orders.where(status: "delivered").sum(:total_bill) rescue "0"
    else
      @orders= []
      @delivered_orders = current_user.orders.where(status: "delivered").count rescue []
      @pending_orders = current_user.orders.where(status: "pending").count rescue []
      @total_cash = current_user.orders.where(status: "delivered").sum(:total_bill) rescue "0"
    end
  end
end
