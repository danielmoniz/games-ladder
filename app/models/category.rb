class Category < ActiveRecord::Base
  has_many :matches
  has_many :games, -> { uniq }, through: :matches
  has_many :teams, -> { uniq }, through: :matches
  has_many :players, -> { uniq }, through: :teams
  has_and_belongs_to_many :players

  def recent_matches
    self.matches.order(created_at: :desc).limit(15)
  end
end
