require "test_helper"

class RegisteredUserLoginTest < ActionDispatch::IntegrationTest
  test 'a registered user can login' do
    login_user

    assert page.has_content?('Logged in as Matt')
    assert page.has_content?('Logout')
  end

  test 'an unregistered guest cannot login' do
    visit login_path
    fill_in 'Username', with: 'GnarBro'
    fill_in 'Password', with: 'lame_password'
    click_button 'Login'

    assert page.has_content?('Invalid Login')
  end

  test 'a registered guest cannot login with the wrong password' do
    create_user
    visit login_path

    within('.login_form') do
      fill_in 'Username', with: 'Matt'
      fill_in 'Password', with: 'powpow'
      click_button 'Login'
    end

    assert page.has_content?('Invalid Login')
  end

  test 'a registered guest cannot login with the wrong username' do
    create_user
    visit login_path

    within('.login_form') do
      fill_in 'Username', with: 'GnarMan'
      fill_in 'Password', with: 'gnargnar'
      click_button 'Login'
    end

    assert page.has_content?('Invalid Login')
  end

  test 'authenticated user can logout' do
    login_user

    assert page.has_content?('Logged in as Matt')

    click_link 'Logout'

    assert page.has_content?("You have successfully logged out.")
  end
end
