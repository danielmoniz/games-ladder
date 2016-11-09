class Match < ActiveRecord::Base
  belongs_to :game
  belongs_to :category
  has_and_belongs_to_many :teams
  belongs_to :match_result, polymorphic: true
  has_one :winner, through: :match_result
  has_many :players, through: :teams

  def name
    if self.read_attribute(:name)
      return self.read_attribute(:name)
    end
    names = self.teams.map do |team|
      if team.players.count > 1
        "'#{team.name}'"
      else
        "#{team.name}"
      end
    end
    names.join(' vs ')
  end
end
