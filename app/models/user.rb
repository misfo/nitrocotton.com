class User < ActiveRecord::Base
  has_many :votes
end
