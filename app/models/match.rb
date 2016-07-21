class Match < ActiveRecord::Base
  belongs_to :game
  belongs_to :category
  has_and_belongs_to_many :teams

  def name
    names = self.teams.map { |team| "'#{team.name}'" }
    names.join(' vs ')
  end
end
