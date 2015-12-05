require 'test_helper'

class PlatformAdminDashboardTest < ActionDispatch::IntegrationTest
  test 'when admin logs they see dashboard page' do
    create_platform_admin
    visit login_path

    fill_in 'Username', with: 'admin'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    assert_equal "/admin/dashboard", current_path
    assert page.has_content?('Welcome, Admin!')
  end

  test 'default user does not see admin dashboard' do
    create_platform_admin
    create_registered_user
    visit login_path

    fill_in 'Username', with: 'user'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    visit admin_dashboard_index_path(User.first.id)
    refute page.has_content?('Welcome, user!')
  end

end
