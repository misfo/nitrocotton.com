class CelebVote < ActiveRecord::Base
  belongs_to :celebrity
  belongs_to :shirt
  belongs_to :user
  
  attr_protected :user_id
end
