class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :shirt

  validates_inclusion_of :vote, :in => [-1, 1]
end
