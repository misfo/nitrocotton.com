require 'open-uri'

class Image < ActiveRecord::Base
  belongs_to :shirt

  has_attachment :content_type => :image,
                 :resize_to => '455x385>',
                 :thumbnails => {:thumb => '167x167!'},
                 :processor => 'Rmagick',
                 :storage => :s3,
                 :path_prefix => "shirts"

  def self.create_from_url(url)
    returning image = new(:original_url => url) do
      image.update_file
      image.save
    end
  end

  def update_file(url=nil)
    url ||= original_url
    io = open(url)
    class << io
      def original_filename
        base_uri.path.split('/').last
      end
    end
    self.uploaded_data = io
    self.original_url  = url
  end
  
  def update_file!(url=nil)
    update_file(url)
    self.updated_at = Time.now
    save!
  end
end
