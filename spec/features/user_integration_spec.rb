require 'spec_helper'

describe User do

  let!(:user) {FactoryGirl.create(:user)}
  let!(:topic) {FactoryGirl.create(:topic)}

  context 'Homepage' do
    before(:each) do
      visit root_path
    end

    it 'Should see list of topics' do
      page.should have_content(topic.title)
    end
  end

  context 'Sign Up' do
    it 'should be able to create an account' do
      visit root_path
      expect {
        click_on 'Sign Up'
        fill_in 'Name', :with => 'example'
        fill_in "E-mail", :with => 'example@example.com'
        fill_in "Password", :with => 'password'
        fill_in "Password Confirmation", :with => 'password'
        click_button "Submit"
      }.to change(User, :count).by(1)

      current_path.should eq root_path
    end
  end

  context 'login' do
    it 'should be able to login' do
      visit root_path
      click_on 'Login'
      fill_in "E-mail", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Submit"
      current_path.should eq root_path
      page.should_not have_link('LOGIN')
    end
  end

  context 'logout', :js => true do
    it 'should be able to logout' do
      visit root_path
      login(user)
      click_on 'LOGOUT'
      page.should have_link('Login')
    end
  end

  context "A Not Signed In User", :js => true do
    before(:each) do
      visit root_path
    end

    it 'should not be able to upvote a topic' do
      page.should have_content(0)
      find('#topics .upvote a').click
      current_path.should eq login_path
    end

    it 'should see link Sign Up' do
      page.should have_link('Sign Up')
    end

    it 'should see link Login' do
      page.should have_link('Login')
    end
  end

  context "A Signed In User", :js => true do
    before(:each) do
      sign_in(user)
      visit root_path
    end

    it 'should be able to upvote a topic' do
      page.should have_content(0)
      find('#topics .upvote a').click
      page.should have_content(1)
    end

    it 'should see link Logout' do
      page.should have_link('Logout')
    end

    it 'should not see link Sign Up' do
      page.should_not have_link('Sign Up')
    end

    it 'should not see link Login' do
      page.should_not have_link('Login')
    end

    it 'should be able to create a topic' do
      click_on("Create Topic")
      fill_in "Title", with: "A New Post"
      fill_in "Comment", with: "This is a new post."
      click_button "Submit"
      page.should have_content("A New Post")
    end
  end

end
