class Shirt < ActiveRecord::Base
  belongs_to :merchant
  has_one :image, :dependent => :destroy
  has_many :celeb_votes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  has_and_belongs_to_many :labels

  validates_uniqueness_of :merchant_url

  after_create :associate_labels
  after_save :download_image
  
  named_scope :highest_rated, {
    :select => "shirts.*, sum_vote",
    :joins => "JOIN (SELECT shirt_id, sum(vote) AS sum_vote FROM votes GROUP BY shirt_id) AS votes ON shirts.id = shirt_id",
    :order => "sum_vote DESC, created_at DESC"
  }
  #TODO benchmark this scope compared to the next
  named_scope :unvoted_and_voted_up_by, lambda { |user| {
    :joins => "LEFT JOIN (SELECT shirt_id, vote FROM votes WHERE user_id = #{user.is_a?(User) ? user.id : user}) AS votes ON shirts.id = shirt_id",
    :conditions => "vote IS NULL OR vote >= 0"
  } }
  named_scope :not_voted_down_by, lambda { |user|
    { :conditions => [
      "shirts.id NOT IN (SELECT shirt_id FROM votes WHERE user_id = ? AND vote < 0)",
      user.is_a?(User) ? user.id : user
    ] }
  }
  named_scope :voted_up_by, lambda { |user|
    { :conditions => [
      "shirts.id IN (SELECT shirt_id FROM votes WHERE user_id = ? AND vote > 0)",
      user.is_a?(User) ? user.id : user
    ] }
  }
  
  class << self
    def page_exists?(url)
      case url
      when /^http:\/\/www\.typetees\.com\//i
        threadless_id = ProductPage::TypeTees.id_from_url(url)
        exists?(["merchant_url LIKE ?", "http://www.typetees.com/product/#{threadless_id}/%"])
      else
        exists?(:merchant_url => url)
      end
    end
    
    def word_frequencies(freq_min = 2)
      find(:all).inject({}) do |words, shirt|
        shirt_words = shirt.text.downcase.scan(/[\w']{2,}/).uniq
        shirt_words -= %w(am as at and are be do for have i'd i'm if in is it it's me my no not of on or our so that that's the they this to us was we were what who you your)
        shirt_words.each {|word| words[word] = (words[word] || 0) + 1 }
        words
      end.select {|w, f| f >= freq_min }.sort_by {|w, f| [-f, w] }
    end
  end

  attr_accessor :image_url
  attr_accessor :label_names

  def voted_celebrities(limit = nil)
    Celebrity.all(:select => %["celebrities".*, votes], :order => "votes DESC", :limit => limit, :joins =>
      "JOIN (SELECT celebrity_id, count(id) AS votes FROM celeb_votes WHERE shirt_id = #{id} GROUP BY celebrity_id) AS celeb_votes ON id = celebrity_id")
  end

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
