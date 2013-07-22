class Topic < ActiveRecord::Base
  attr_accessible :title, :content, :anonymous

  belongs_to :user
  has_many :comments
  has_many :upvotes
  has_many :users, :through => :upvotes

  has_many :scores


  validates :title, :content, :presence => true
  validates :title, uniqueness: true
  before_create :to_slug

  def to_param
    slug
  end

  def created_by?(user)
    self.user == user
  end

  # def self.sorted_by_upvotes
  #   self.all.sort {|topic1, topic2| topic2.upvotes.count <=> topic1.upvotes.count }
  # end

  def upvoters
    self.users
  end

  def avg_a
    actionable_total = self.scores.inject(0){|sum, score| sum + score.actionable unless score.actionable.nil?}
    (actionable_total.to_f/self.scores.count).round(2)
  end

  def avg_s
    specific_total = self.scores.inject(0){|sum, score| sum + score.specific unless score.actionable.nil?}
    (specific_total.to_f/self.scores.count).round(2)
  end

  def avg_k
    kind_total = self.scores.inject(0){|sum, score| sum + score.kind unless score.actionable.nil?}
    (kind_total.to_f/self.scores.count).round(2)
  end



  private
    def to_slug
      self.slug = self.title.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
    end
end
