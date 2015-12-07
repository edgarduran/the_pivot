require 'test_helper'

class AnAdminCanFilterOrdersByStatusTest < ActionDispatch::IntegrationTest
  test 'admin can view paid orders' do
    create_user
    create_user_order(2, "paid")

    login_platform_admin

    click_link('View Paid')

    assert_equal admin_dashboard_path('paid'), current_path


    within('.orders') do
      assert page.has_content?('Placed On')
      assert page.has_content?('Status')
      assert page.has_content?('paid')
    end
  end

  test 'admin can view canceled orders' do
    create_user
    create_user_order(2, "canceled")

    login_platform_admin
    save_and_open_page
    click_link('View Canceled')

    assert_equal admin_dashboard_path('canceled'), current_path

    within('.orders') do
      assert page.has_content?('Placed On')
      assert page.has_content?('Status')
      assert page.has_content?('canceled')
    end
  end

  test 'admin can view completed orders' do
    create_user
    create_user_order(2, "completed")

    login_platform_admin
    save_and_open_page
    click_link('View Completed')

    assert_equal admin_dashboard_path('completed'), current_path

    within('.orders') do
      assert page.has_content?('Placed On')
      assert page.has_content?('Status')
      assert page.has_content?('completed')
    end
  end

  test 'admin can view ordered orders' do
    create_user
    create_user_order(2, "ordered")

    login_platform_admin
    click_link('View Ordered')

    assert_equal admin_dashboard_path('ordered'), current_path

    within('.orders') do
      assert page.has_content?('Placed On')
      assert page.has_content?('Status')
      assert page.has_content?('ordered')
    end
  end
end
