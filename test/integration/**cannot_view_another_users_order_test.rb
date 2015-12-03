require 'test_helper'

class CannotViewAnotherUsersOrderTest < ActionDispatch::IntegrationTest
  test 'a registered user cannot view another users orders' do
    create_categories_items_user_order_and_login
    old_user = User.first

    visit '/orders'
    assert page.has_content?('Your Orders')
    assert page.has_content?('ordered')

    click_link('View Order')
    within('.orders-table') do
      assert page.has_content?('$2000')
      assert page.has_content?('Gnar possum')
    end
    click_link('Logout')

    create_and_login_additional_users(1)
    current_user = User.last

    assert_equal 2, User.count
    assert_equal 'name1', current_user.username
    assert_equal 'Matt', old_user.username
    assert_equal "/users/#{current_user.id}", current_path

    visit '/orders'
    refute page.has_content?('$2000')
    refute page.has_content?('Gnar possum')
  end
end
