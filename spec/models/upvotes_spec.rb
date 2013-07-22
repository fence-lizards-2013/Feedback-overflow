require 'spec_helper'
describe Upvote do
  let(:user) {FactoryGirl.create(:user_with_topics)}
  it 'should let a user upvote a topic' do
    Upvote.create(user_id: 1, topic_id: 1)
    user.topics.find(1).upvotes.count.should eq(1)
  end
  it 'should not let a user upvote the same post twice' do
    2.times{ Upvote.create(user_id: 1, topic_id: 1) }
    user.topics.find(1).upvotes.count.should eq(1)
  end

end
