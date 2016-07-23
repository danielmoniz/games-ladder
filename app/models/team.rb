class Team < ActiveRecord::Base
  has_and_belongs_to_many :matches
  has_and_belongs_to_many :players

  # has_many :wins, through: :matches, source: :winner
  has_many :results, through: :matches, source: :match_result

  def recent_matches
    self.matches.order(created_at: :desc).limit(15)
  end

  def wins
    self.results.where(winner_id: self.id).order(created_at: :desc)
  end

  def losses
    self.results.where('winner_id != ?', self.id).order(created_at: :desc)
  end

  def name
    if self.read_attribute(:name)
      return self.read_attribute(:name)
    end
    names = self.players.map { |player| player.name }
    names.join(' y ')
  end
end
