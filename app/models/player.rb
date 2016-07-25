class Player < ActiveRecord::Base
  authenticates_with_sorcery!

  has_and_belongs_to_many :teams
  has_many :matches, through: :teams

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  def recent_matches
    self.matches.order(created_at: :desc).limit(15)
  end
end
