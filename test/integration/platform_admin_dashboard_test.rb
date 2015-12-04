require 'test_helper'

class PlatformAdminDashboardTest < ActionDispatch::IntegrationTest
  test 'logged in admin sees dashboard page' do
    admin = User.create(username: 'admin',
                        password: 'password')
    role =  Role.create(name: 'platform_admin')
    admin.roles << role
    # ApplicationController.any_instance.stubs(:current_user).returns(admin)
    visit login_path


    fill_in 'Username', with: 'admin'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    visit admin_dashboard_path(admin)
    save_and_open_page 
    assert page.has_content?('Welcome, Admin!')
  end

  test 'when admin logs they are redirected to dashboard page' do
    skip
    admin = User.create(username: 'admin',
                        password: 'password',
                        role:      1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    visit login_path
    fill_in 'Username', with: 'admin'
    fill_in 'Password', with: 'password'
    click_button 'Login'
    assert page.has_content?('Welcome, Admin!')
  end

  test 'default user does not see admin dashboard' do
    skip
    user = User.create(username: 'default_user',
                       password: 'password',
                       role:      'registered_user')

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit admin_dashboard_index_path(user)

    refute page.has_content?('Welcome, Default_user!')
    assert page.has_content?("The page you were looking for doesn't exist.")
  end

  test 'admin can send an email to all users with daily deal' do
    skip
    User.create(username: 'MattR', password: 'password', email: 'matt@email.com')
    User.create(username: 'Edgar', password: 'password', email: 'edgar@email.com')
    User.create(username: 'MattS', password: 'password', email: 'stj@email.com')
    create_items_associated_with_orders

    admin = User.create(username: 'admin',
                        password: 'password',
                        role:      1)

    visit login_path
    fill_in 'Username', with: 'admin'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    visit admin_dashboard_index_path(admin)

    assert page.has_content?('Welcome, Admin!')

    click_link 'Send Daily Deal Email to All Registered Users'

    assert_equal current_path, '/admin/dashboard'
  end
end
