require 'spec_helper'

describe User do
  let!(:user) {FactoryGirl.create(:user)}

  subject { user }
  it { should_not allow_value("foo").for(:email) }
  it {expect(user.password.length > 6).to eq true}
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  # it { should validate_presence_of(:password) }
  it {(:remember_token).should_not be_nil}

  it 'should encrypt the password on save' do
    expect{user.password_digest}.to_not eq 'password'
  end

  it 'should downcase the email upon save' do
    expect(user.email).to eq user.email.downcase
  end
end
