class Shirt < ActiveRecord::Base
  belongs_to :merchant
  has_one :image, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  has_and_belongs_to_many :labels

  validates_uniqueness_of :merchant_url

  after_create :associate_labels
  after_save :download_image
  
  class << self
    def find_all_with_preference(options)
      returning(shirts = []) do
        options[:order] = "RANDOM()"
        avoid_ids = options.delete(:avoid_ids)
        prefer_high_rated = options.delete(:prefer_high_rated)
        if prefer_high_rated
          top_16_ids = Vote.sum(:vote,
            :group => :shirt_id,
            :conditions => ["created_at > ?", 1.week.ago],
            :order => "sum_vote DESC",
            :limit => 16).collect(&:first)
          shirts.push(*find(top_16_ids - (avoid_ids || []), options))
        end
        if shirts.size < options[:limit] && !avoid_ids.blank?
          with_scope(:find => {:conditions => ["shirts.id NOT IN (?)", avoid_ids]}) do
            shirts.push(*find(:all, options))
          end
        end
        if shirts.size < options[:limit]
          shirts.push(*find(:all, options.merge(:limit => options[:limit] - shirts.size)))
        end
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
