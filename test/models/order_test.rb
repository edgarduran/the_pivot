require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  
  test 'an order can have one item' do
    user = User.create(username: 'Matt', password: 'password')
    item = Item.create(name: 'gnar possum',
                       description: 'a snowboard for shredding gnar pow',
                       price: 1000)

    item.orders.create(current_status: 'completed',
                       total_price: 1000,
                       user_id: user.id)

    assert_equal 1, item.orders.count
  end

  test 'an order belongs to a user' do
    user = User.create(username: 'Matt', password: 'password')

    user.orders.create(current_status: 'completed')

    assert_equal 1, user.orders.count
    assert_equal 'completed', user.orders.first.current_status
  end

  test 'a user can have many orders' do
    user = User.create(username: 'Matt', password: 'password')

    user.orders.create(current_status: 'completed')
    user.orders.create(current_status: 'paid')
    user.orders.create(current_status: 'ordered')

    assert_equal 3, user.orders.count
    assert_equal 'completed', user.orders.first.current_status
    assert_equal 'ordered', user.orders.last.current_status
  end

  test 'an order is saved with a total price' do
    create_items
    order = Order.new(current_status: 'completed')
    order_item = OrderItem.new(item_id: Item.last.id, order_id: order.id, quantity: 2)
    order.order_items << order_item
    order.save

    assert_equal 15, Item.last.price
    assert_equal 2, order_item.quantity
    assert_equal 30, order_item.quantity * Item.last.price

    assert_equal 30, order.total_price
  end

end
