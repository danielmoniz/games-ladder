class Match < ActiveRecord::Base
  belongs_to :games
  belongs_to :category
  has_and_belongs_to_many :teams
end
