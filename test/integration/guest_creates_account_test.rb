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

    assert_equal dashboard_path, current_path
    assert page.has_content?('Logged in as Matt')
  end

  test 'guest recieves error message if username is not entered' do
    visit new_user_path
    click_button 'Create Account'

    assert_equal new_user_path, current_path
    assert page.has_content?('Username and password are required.')
  end
end
