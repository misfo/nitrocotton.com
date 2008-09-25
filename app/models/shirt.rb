class Shirt < ActiveRecord::Base
  belongs_to :merchant
  has_one :image, :dependent => :destroy
  has_many :comments
  has_many :votes do
    def by(user)
      vote = detect {|v| v.user_id == user.id }
      vote ? vote.vote : nil
    end
  end
  has_and_belongs_to_many :labels

  validates_uniqueness_of :merchant_url

  after_create :associate_labels
  after_save :download_image

  attr_accessor :image_url
  attr_accessor :label_names

protected
  def associate_labels
    unless @label_names.blank?
      for label in @label_names.split(",")
        labels << Label.find_or_create_by_name(label.strip) unless label.blank?
      end
    end
  end

  def download_image
    if @image_url
      image = build_image
      image.update_file(@image_url)
      image.save!
    end
  end
end
