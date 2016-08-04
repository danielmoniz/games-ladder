class Authentication < ActiveRecord::Base
  # attr_accessible :user_id, :provider, :uid
  belongs_to :user, foreign_key: 'user_id', :class_name => "Player" 
end
