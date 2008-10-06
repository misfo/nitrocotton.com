require 'open-uri'

class Image < ActiveRecord::Base
  belongs_to :shirt

  has_attachment :content_type => :image,
                 :resize_to => '450x550>',
                 :thumbnails => {:thumb => '200x200!'},
                 :processor => 'Rmagick',
                 :storage => defined?(HerokuApp) ? 'heroku' : 'file_system',
                 :path_prefix => "public/images/shirts"

  def self.create_from_url(url)
    returning image = new(:original_url => url) do
      image.update_file
      image.save
    end
  end

  def update_file(url=original_url)
    io = open(url)
    class << io
      def original_filename
        base_uri.path.split('/').last
      end
    end
    self.uploaded_data = io
    self.original_url  = url
  end
end
