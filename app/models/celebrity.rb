class Celebrity < ActiveRecord::Base
  def image_path
    "/images/celebs/#{filename}"
  end
end
