require 'test_helper'

class StoreAdminDashboardTestTest < ActionDispatch::IntegrationTest
  test 'when store admin logs they see dashboard page' do
    login_store_admin

    assert_equal "/#{Store.first.slug}/dashboard/#{User.first.store_id}", current_path
    assert page.has_content?('Welcome, Dave!')
  end

  test 'platform admin does not see admin dashboard' do
    create_store_admin
    create_platform_admin
    visit login_path

    fill_in 'Username', with: 'admin'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    visit "/#{User.first.store.slug}/dashboard/#{User.first.store_id}"

    refute page.has_content?('Welcome, user!')
  end

  test 'registered user does not see admin dashboard' do
    create_store_admin
    create_registered_user
    visit login_path

    fill_in 'Username', with: 'user'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    visit "/#{User.first.store.slug}/dashboard/#{User.first.store_id}"
    refute page.has_content?('Welcome, user!')
  end
end
