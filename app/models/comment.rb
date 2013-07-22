class Comment < ActiveRecord::Base
  attr_accessible :content, :topic_id
  belongs_to :topic
  belongs_to :user

  validates :content, :presence => true

  def created_by?(user)
    self.user == user
  end

end
