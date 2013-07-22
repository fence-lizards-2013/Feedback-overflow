class Score < ActiveRecord::Base
  attr_accessible :user_id, :topic_id, :specific, :actionable, :kind
  belongs_to :user
  belongs_to :topic
  validates_uniqueness_of :user_id, :scope => :topic_id
end
