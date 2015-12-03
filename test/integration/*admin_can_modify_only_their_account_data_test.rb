require 'test_helper'

class AdminCanModifyOnlyTheirAccountDataTest < ActionDispatch::IntegrationTest
  test 'admin can modify their account data' do
    admin = User.create(username: 'admin',
                        password: 'password',
                        role:      1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    visit admin_dashboard_index_path(admin)
    assert page.has_content?('Welcome, Admin!')
    click_link 'Edit Account'
    assert page.has_content?('Edit User Profile')

    fill_in 'Username', with: 'NewName'
    fill_in 'Password', with: 'newpassword'
    click_button 'Save Changes'
    assert page.has_content?('Welcome, Newname!')
  end
end
