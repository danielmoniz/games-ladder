class Game < ActiveRecord::Base
  has_many :matches

  def recent_matches
    self.matches.order(created_at: :desc).limit(15)
  end
end
