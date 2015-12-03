require 'test_helper'

class RegisteredUserCanViewPastOrderDetailsTest < ActionDispatch::IntegrationTest
  test 'user can view past order details' do
    create_cars(1)
    login_user
    current_user = User.first

    order = current_user.orders.create(current_status: 'ordered',
                                       total_price: 1335)

    order.order_items.create(car_id: Car.first.id, order_id: order.id, days: 2)

    visit '/orders'

    click_link 'View Order'

    assert_equal order_path(order), current_path
    assert page.has_content?('Order Number')
    assert page.has_content?('Order Status')
    assert page.has_content?('Total')
    assert page.has_content?('Submitted on')

    within('.orders-table') do
      assert page.has_content?('1960 Chevy0 El Camino0')
      assert page.has_content?('$100')
      assert page.has_content?('$200')
      assert page.has_content?('2')
    end
  end

  test 'user can view past order details for multiple items' do
    create_cars(2)
    login_user
    current_user = User.first

    order = current_user.orders.create(current_status: 'ordered',
                                       total_price: 1335)

    order.order_items.create(car_id: Car.first.id, order_id: order.id, days: 2)
    order.order_items.create(car_id: Car.last.id, order_id: order.id, days: 10)

    visit '/orders'

    click_link 'View Order'

    assert_equal order_path(order), current_path
    assert page.has_content?('Order Number')
    assert page.has_content?('Order Status')
    assert page.has_content?('Total')
    assert page.has_content?('Submitted on')
    save_and_open_page
    within('.orders-table') do
      assert page.has_content?('1960')
      assert page.has_content?('1961')
      assert page.has_content?('$100')
      assert page.has_content?('$101')
      assert page.has_content?('$200')
      assert page.has_content?('$1010')
      assert page.has_content?('$1210')
    end
  end
end
