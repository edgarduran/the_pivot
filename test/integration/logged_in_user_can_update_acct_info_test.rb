require 'test_helper'

class LoggedInUserCanUpdateAcctInfoTest < ActionDispatch::IntegrationTest
  test 'user can update account info' do
    login_user
    assert page.has_content?('Logged in as Matt')

    click_link "EDIT PROFILE"

    assert_equal edit_user_path(User.first), current_path

    fill_in 'Username', with: 'Edgar'
    fill_in 'Password', with: 'newpassword'
    fill_in 'Email', with: 'new@mail.com'
    click_button 'Save Changes'

    assert page.has_content?('Email: new@mail.com')
    assert page.has_content?("Edgar's Profile")
    assert page.has_content?('You have successfully updated your profile.')
  end
end
