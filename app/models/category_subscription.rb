class CategorySubscription < ActiveRecord::Base
  belongs_to :player
  belongs_to :category

  validate :not_duplicate, :on => :create

  def not_duplicate
    if CategorySubscription.find_by(category_id: self.category_id, player_id: self.player_id)
      errors.add :base, 'You are already subscribed to this category.'
    end
  end

  # validates_each :category_id, :on => :create do |record, attr, value|
  #   if value && record.player_id && # If no values, then that problem
  #                                   # will be caught by another validator
  #     CategoryPost.find_by(category_id: value, player_id: record.player_id)
  #     record.errors.add :base, 'You are already subscribed to this category.'
  #   end
  # end
end
