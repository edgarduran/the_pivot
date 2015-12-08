require 'test_helper'

class PlatformAdminCanModifyOnlyTheirAccountDataTest < ActionDispatch::IntegrationTest
  test 'platform admin can modify their account data' do
    login_platform_admin

    visit admin_dashboard_index_path(User.first)

    assert page.has_content?('Welcome, Admin!')

    click_link 'Edit Account'

    assert page.has_content?('Edit User Profile')

    fill_in 'Username', with: 'NewName'
    fill_in 'Password', with: 'newpassword'
    click_button 'Save Changes'

    assert page.has_content?('Welcome, Newname!')
  end
end
