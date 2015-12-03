require 'test_helper'

class AdminCanSeeOrdersTest < ActionDispatch::IntegrationTest
  
  test 'logged in admin sees dashboard page with orders' do
    admin = User.create(username: 'admin',
                        password: 'password',
                        role:      1)
    create_items_associated_with_orders
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    visit login_path
    fill_in 'Username', with: 'admin'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    assert page.has_content?('Welcome, Admin!')
    within('.all-orders') do
      assert page.has_content?('Status')
      assert page.has_content?('Total Price')
      assert page.has_content?('$160')
      assert page.has_link?('View Order')
    end
  end
  test 'admin sees order numbers by status' do
    admin = User.create(username: 'admin',
                        password: 'password',
                        role:      1)
    create_items_associated_with_orders
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    visit login_path
    fill_in 'Username', with: 'admin'
    fill_in 'Password', with: 'password'
    click_button 'Login'
    within('.by-status') do
      assert page.has_content?('Ordered')
      assert page.has_content?('Canceled')
      assert page.has_content?('Completed')
      assert page.has_content?('2')
    end
  end
end
