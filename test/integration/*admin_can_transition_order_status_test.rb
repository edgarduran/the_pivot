require 'test_helper'

class AdminCanTransitionOrderStatusTest < ActionDispatch::IntegrationTest
  test 'admin can transition order status from ordered to cancel test' do
    admin_order_setup('completed')

    within("#order_#{Order.last.id}") do
      assert page.has_content?('completed')
      assert page.has_link?('View Order')
      assert page.has_link?('Cancel')
      click_link('Cancel')
    end

    assert admin_dashboard_index_path, current_path

    within("#order_#{Order.last.id}") do
      assert page.has_content?('canceled')
      refute page.has_link?('Cancel')
    end
  end

  test 'admin can transition order status from paid to canceled test' do
    admin_order_setup('paid')

    within("#order_#{Order.last.id}") do
      assert page.has_content?('paid')
      assert page.has_link?('View Order')
      assert page.has_link?('Cancel')
      click_link('Cancel')
    end

    assert admin_dashboard_index_path, current_path

    within("#order_#{Order.last.id}") do
      assert page.has_content?('canceled')
      refute page.has_link?('Cancel')
    end
  end

  test 'admin can transition order status from ordered to paid test' do
    admin_order_setup('ordered')

    within("#order_#{Order.last.id}") do
      assert page.has_content?('ordered')
      assert page.has_link?('View Order')
      assert page.has_link?('Mark as paid')
      click_link('Mark as paid')
    end

    assert admin_dashboard_index_path, current_path

    within("#order_#{Order.last.id}") do
      assert page.has_content?('paid')
      assert page.has_link?('Cancel')
    end
  end

  test 'admin can mark paid orders as complete' do
    admin_order_setup('paid')

    within("#order_#{Order.last.id}") do
      assert page.has_content?('paid')
      assert page.has_link?('View Order')
      assert page.has_link?('Mark as complete')
      click_link('Mark as complete')
    end

    assert admin_dashboard_index_path, current_path

    within("#order_#{Order.last.id}") do
      assert page.has_content?('complete')
      assert page.has_link?('Cancel')
    end
  end
end
