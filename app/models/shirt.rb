class Shirt < ActiveRecord::Base
  belongs_to :merchant
  has_one :image, :dependent => :destroy
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
    def top_rated_since(time, limit=nil)
      all(:select => "sum(vote) AS sum_vote, shirt_id, shirts.*",
        :conditions => ["votes.created_at > ?", time],
        :joins => :votes, :group => :shirt_id, :order => "sum_vote DESC", :limit => limit)
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
