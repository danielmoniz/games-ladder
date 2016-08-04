class Game < ActiveRecord::Base
  has_many :matches
  has_many :categories, -> { uniq }, through: :matches
  has_many :teams, -> { uniq }, through: :matches
  has_many :players, -> { uniq }, through: :teams

  def recent_matches(category=nil)
    if category
      self.matches.where(category_id: category.id).order(created_at: :desc).limit(75)
    else
      self.matches.order(created_at: :desc).limit(75)
    end
  end
end
