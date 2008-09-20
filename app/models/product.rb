class Product < ActiveRecord::Base
  belongs_to :merchant
  has_one :image, :dependent => :destroy
  has_many :comments
  has_many :votes do
    def by(user)
      vote = detect {|v| v.user_id == user.id }
      vote ? vote.vote : nil
    end
  end

  validates_uniqueness_of :merchant_url
end
