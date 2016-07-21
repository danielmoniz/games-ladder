class Player < ActiveRecord::Base
  authenticates_with_sorcery!

  has_and_belongs_to_many :teams
  has_many :matches, through: :teams
end
