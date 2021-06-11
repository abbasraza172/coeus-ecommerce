class Order < ApplicationRecord
  #callback
  after_update :send_feedback_email

  #Sends email to customer for feedback
  #
  #It checks if the status of order is changed form
  #any status other than "delivered" to "delivered"
  #it sends an email to order's customer to give feedback
  def send_feedback_email
    if self.status_before_last_save != "delivered" && self.delivered?
      OrderMailer.with(order: self).delivered_order_email.deliver_later
    end
  end

  #belongs to associations
  belongs_to :user

  #has many associations
  has_many :feedbacks
  has_many :order_products
  has_many :products, through: :order_products
  has_many :businesses, through: :products

  #enum for status
  enum status: { pending: 0, accepted: 1, rejected: 2, processing: 3, canceled: 4, delivered: 5 }
end
