require 'spec_helper'

describe Topic do
  let(:topic) {FactoryGirl.create(:topic)}
  it {(topic.slug).should_not be_nil}
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
end
