require 'test_helper'

class AnAdminCanFilterOrdersByStatusTest < ActionDispatch::IntegrationTest
  test 'admin can view paid orders' do
    admin = User.create(username: 'admin',
                        password: 'password',
                        role:      1)

    create_items_associated_with_orders

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_index_path(admin)

    click_link('View Paid')

    assert_equal admin_dashboard_path('paid'), current_path

    within('.orders') do
      assert page.has_content?('Placed On')
      assert page.has_content?('Status')
      assert page.has_content?('paid')
    end
  end

  test 'admin can view canceled orders' do
    admin = User.create(username: 'admin',
                        password: 'password',
                        role:      1)

    create_items_associated_with_orders

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_index_path(admin)

    click_link('View Canceled')

    assert_equal admin_dashboard_path('canceled'), current_path

    within('.orders') do
      assert page.has_content?('Placed On')
      assert page.has_content?('Status')
      assert page.has_content?('canceled')
    end
  end

  test 'admin can view completed orders' do
    admin = User.create(username: 'admin',
                        password: 'password',
                        role:      1)

    create_items_associated_with_orders

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_index_path(admin)

    click_link('View Completed')

    assert_equal admin_dashboard_path('completed'), current_path

    within('.orders') do
      assert page.has_content?('Placed On')
      assert page.has_content?('Status')
      assert page.has_content?('completed')
    end
  end

  test 'admin can view ordered orders' do
    admin = User.create(username: 'admin',
                        password: 'password',
                        role:      1)

    create_items_associated_with_orders

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_index_path(admin)

    click_link('View Ordered')

    assert_equal admin_dashboard_path('ordered'), current_path

    within('.orders') do
      assert page.has_content?('Placed On')
      assert page.has_content?('Status')
      assert page.has_content?('ordered')
    end
  end
end
