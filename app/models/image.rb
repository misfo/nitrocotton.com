require 'open-uri'

class Image < ActiveRecord::Base
  belongs_to :shirt

  has_attachment :content_type => :image,
                 :resize_to => '450x550>',
                 :thumbnails => {:thumb => '200x200!'},
                 :path_prefix => 'public/images/shirts'

  def self.create_from_url(url)
    returning image = new(:original_url => url) do
      image.update_file
      image.save
    end
  end

  def update_file(url=original_url)
    data = open(url)
    self.content_type = data.content_type
    self.filename     = File.basename(url)
    self.original_url = url
    self.temp_path    = data.path
  end
end
