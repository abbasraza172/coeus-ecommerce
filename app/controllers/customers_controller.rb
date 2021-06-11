class CustomersController < ApplicationController
  layout "default_layout"

  def my_account
    @orders = current_user.orders
  end
end
