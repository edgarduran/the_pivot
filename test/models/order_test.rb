require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test 'an order belongs to a user' do
    create_user
    create_user_order(1)

    assert_equal 1, User.first.orders.count
  end

  test 'a user can have many orders' do
    create_user
    create_user_order(1)
    user = User.first
    user.orders.create

    assert_equal 2, user.orders.count
  end

  test 'an order is saved with a total price' do
    create_user
    create_user_order(1)

    assert_equal 200, Order.first.total_price
  end

end
