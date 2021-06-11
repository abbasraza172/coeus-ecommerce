class OrderMailer < ApplicationMailer
  def delivered_order_email
    @order = params[:order]
    mail(to: @order.user.email, subject: "Coeus Express | Order Delivered | Please rate your order!")
  end
end
