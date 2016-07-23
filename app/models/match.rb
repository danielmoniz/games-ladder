class Match < ActiveRecord::Base
  belongs_to :game
  belongs_to :category
  has_and_belongs_to_many :teams
  has_one :match_result
  has_one :winner, through: :match_result
  has_many :players, through: :teams

  def name
    if self.read_attribute(:name)
      return self.read_attribute(:name)
    end
    names = self.teams.map { |team| "'#{team.name}'" }
    names.join(' vs ')
  end
end
