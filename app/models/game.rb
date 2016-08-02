class Game < ActiveRecord::Base
  has_many :matches
  has_many :categories, -> { uniq }, through: :matches
  has_many :teams, -> { uniq }, through: :matches
  has_many :players, -> { uniq }, through: :teams

  def recent_matches
    self.matches.order(created_at: :desc)
  end

  def recent_matches_in_category(category)
    self.matches.where(category_id: category.id).order(created_at: :desc)
  end
end
