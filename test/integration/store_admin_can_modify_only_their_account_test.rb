require 'test_helper'

class StoreAdminCanModifyOnlyTheirAccountTest < ActionDispatch::IntegrationTest
  test 'store admin can modify their account data' do
    login_store_admin

    assert page.has_content?('Welcome, Dave!')

    click_link 'Edit Account'

    assert page.has_content?('Edit User Profile')

    fill_in 'Username', with: 'NewName'
    fill_in 'Password', with: 'newpassword'
    click_button 'Save Changes'

    assert page.has_content?("New Name's Profile")
  end
end
