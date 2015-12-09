require 'test_helper'

class CannotViewAnotherUsersDashboardTest < ActionDispatch::IntegrationTest
  test 'a registered user cannot view another users dashboard' do
    create_user
    create_and_login_additional_user

    assert_equal dashboard_path, current_path

    assert page.has_content?("Molly's Profile")

    visit dashboard_path(id: 234556)

    assert page.has_content?("Molly's Profile")
  end
end
