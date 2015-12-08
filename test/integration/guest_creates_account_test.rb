require 'test_helper'

class GuestCreatesAccountTest < ActionDispatch::IntegrationTest
  test 'guest can create an account' do
    visit '/'
    click_link 'Login'
    click_link 'Create an account'

    assert_equal new_user_path, current_path

    fill_in 'Username', with: 'Matt'
    fill_in 'Password', with: 'gnargnar'
    click_button 'Create Account'

    assert_equal user_path(User.first), current_path
    assert page.has_content?('Logged in as Matt')
  end
end
