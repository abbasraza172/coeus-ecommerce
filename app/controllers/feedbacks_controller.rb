class FeedbacksController < ApplicationController
  layout "feedback_layout"

  def new
    path = validate_feedback(params)
    unless path.nil?
      return redirect_to path
    end

    # @order = Order.find(params[:order_id])
    # if (@order.feedbacks.where(user_id: params[:user_id], reviewable_type: params[:reviewable_type].camelize, reviewable_id: params[:reviewable_id].to_i))
    #   next_path = give_next_feedback_path
    #   unless next_path.nil?
    #     byebug
    #     return redirect_to next_path
    #   end
    # end

    @feedback = Feedback.new
    @feedback.user_id = params[:user_id]
    @feedback.order_id = params[:order_id]
    @feedback.reviewable_type = params[:reviewable_type].camelize.constantize
    @feedback.reviewable_id = params[:reviewable_id]
    @reviewable_name = (params[:reviewable_type].camelize.constantize).find(params[:reviewable_id]).name
  end

  def feedback_params
    params.require(:feedback).permit(:stars, :user_id, :created_at, :id, :reviewable_type, :reviewable_id, :review, :order_id)
  end

  def create
    path = validate_feedback(feedback_params)
    unless path.nil?
      return redirect_to path
    end
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      @order = Order.find(feedback_params[:order_id])
      path = give_next_feedback_path
    else
      # render :action => "create"
    end
    return redirect_to path
  end

  private

  #Validates if the feedback is being given with correct params
  #
  #It receives params and validates them whether given params
  #for feedback are valid or not. If they are valid, it returns nil.
  #If not valid, it returns index_path.
  def validate_feedback(feedback_params)
    path = nil
    order = Order.find(feedback_params[:order_id])
    if order && order.user_id == feedback_params[:user_id].to_i
      if feedback_params[:reviewable_type].camelize == "Product"
        if !order.products.ids.include?(feedback_params[:reviewable_id].to_i)
          path = index_path
        end
      elsif feedback_params[:reviewable_type].camelize == "Business"
        if !order.businesses.distinct.ids.include?(feedback_params[:reviewable_id].to_i)
          path = index_path
        end
      else
        path = index_path
      end
    else
      path = index_path
    end
    path
  end

  #Gives the next feedback path
  #
  #If an order has some missing feedbacks about product or
  #business then it returns the path for next missing feedback.
  #If all feedbacks has already been given then it returns index_path.
  def give_next_feedback_path
    path = index_path
    business_ids = @order.feedbacks.where(reviewable_type: "Business").pluck(:reviewable_id)
    @order.businesses.each do |business|
      unless business_ids.include?(business.id)
        path = new_feedback_path(user_id: @order.user.id, order_id: @order.id, reviewable_type: "business", reviewable_id: business.id)
        break
      end
    end
    if path == index_path
      product_with_feedback_ids = @order.feedbacks.where(reviewable_type: "Product").pluck(:reviewable_id)
      @order.products.each do |product|
        unless product_with_feedback_ids.include?(product.id)
          path = new_feedback_path(user_id: @order.user.id, order_id: @order.id, reviewable_type: "product", reviewable_id: product.id)
          break
        end
      end
    end
    path
  end
end
