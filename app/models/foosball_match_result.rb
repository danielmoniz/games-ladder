class FoosballMatchResult < ActiveRecord::Base
  has_one :match, as: :match_result
  belongs_to :winner, foreign_key: :winner_id, class_name: "Team"
end
