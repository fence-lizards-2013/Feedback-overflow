module CapybaraHelpers
  def login(user)
    click_on 'Login'
    fill_in "E-mail", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Submit"
  end

  def sign_in(user)
    ApplicationController.any_instance.stub(:current_user) { user }
  end
end
