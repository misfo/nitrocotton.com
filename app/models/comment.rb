class Comment < ActiveRecord::Base
  #TODO belongs_to :user
  
  validates_length_of :name, :maximum => 30, :allow_blank => true
  validates_format_of :url, :with => /\Ahttps?:\/\//, :allow_blank => true
  validates_length_of   :body, :in => 1..5000

  before_validation :normalize_name, :normalize_url

  protected
    def normalize_name
      self.name = name.blank? ? nil : name.strip
    end

    def normalize_url
      if url.blank?
        self.url = nil
      elsif url !~ /\A[a-z]+:\/\//i
        url.insert(0, "http://")
      end
    end
end
