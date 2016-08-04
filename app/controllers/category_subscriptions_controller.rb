class CategorySubscriptionsController < ApplicationController
  before_action :require_login

  def create
    category = Category.find(params[:category_id])
    category.players << current_user
    redirect_back_or_to category, notice: "Subscribed to #{category.name}."
  end

  def destroy
    # @TODO Ensure favourite category data is destroyed as well
    subscription = CategorySubscription.find_by(subscription_params)
    if subscription
      subscription.destroy
      redirect_back_or_to current_user, notice: "Removed subscription to #{subscription.category.name}."
    end
    redirect_back_or_to current_user, notice: "No subscription removed."
  end

  private
  def subscription_params
    params.permit(:player_id, :id)
  end
end
