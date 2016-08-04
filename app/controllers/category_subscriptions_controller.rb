class CategorySubscriptionsController < ApplicationController
  before_action :require_login

  def create
    category = Category.find(params[:category_id])
    # @TODO Ensure people do not subscribe twice
    # category_subscription = CategorySubscription.new
    category.players << current_user
    # current_user.categories << category
    redirect_back_or_to category, notice: "Subscribed to #{category.name}."
  end

  def destroy
  end

  private
  def subscription_params
    params.permit(:category_id)
  end
end
