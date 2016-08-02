class Player < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  has_and_belongs_to_many :teams
  has_many :matches, through: :teams

  belongs_to :favourite_game, class_name: 'Game', foreign_key: :favourite_game_id
  belongs_to :favourite_category, class_name: 'Category', foreign_key: :favourite_category_id
  has_and_belongs_to_many :categories

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  def recent_matches
    self.matches.order(created_at: :desc).limit(15)
  end

  def name
    if self.read_attribute(:name) and self.read_attribute(:name) != ''
      return self.read_attribute(:name)
    end
    self.email.split('@').first
  end
end
