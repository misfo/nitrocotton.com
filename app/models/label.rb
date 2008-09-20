class Label < ActiveRecord::Base
  has_and_belongs_to_many :shirts

  validates_uniqueness_of :name
end
