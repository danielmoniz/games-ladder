class Category < ActiveRecord::Base
  has_many :matches
  has_many :games, -> { uniq }, through: :matches
  has_many :teams, -> { uniq }, through: :matches
  has_many :match_players, -> { uniq }, through: :matches, source: :players
  # has_and_belongs_to_many :players

  has_many :category_subscriptions
  has_many :players, through: :category_subscriptions

  def recent_matches
    self.matches.order(created_at: :desc).limit(15)
  end

  def top_players
    self.match_players
  end
end
