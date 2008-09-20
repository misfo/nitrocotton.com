class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates_inclusion_of :vote, :in => [-1, 1]
end
