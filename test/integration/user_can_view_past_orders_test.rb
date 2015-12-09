require 'test_helper'

class UserCanViewPastOrdersTest < ActionDispatch::IntegrationTest
  test 'user can view one past order' do
    login_user
    create_user_order(1)

    visit '/orders'

    assert page.has_content?('Your Orders')
    assert page.has_content?('Pending')
  end

  test 'user can view a list of all past orders' do
    login_user
    create_user_order(1)

    order = User.first.orders.create(current_status: 'paid')

    order.order_items.create(car_id: Car.first.id, order_id: order.id, days: 2)

    visit '/orders'

    assert page.has_content?('Your Orders')
    assert page.has_content?('Paid')
  end
end
