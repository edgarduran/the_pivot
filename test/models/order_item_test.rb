require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test 'cars are asscociated with an order' do
    create_cars(1)
    order = Order.new(current_status: 'completed')
    order_item = OrderItem.new(car_id: Car.last.id, order_id: order.id, days: 2)
    order.order_items << order_item
    order.save

    assert order.valid?
    assert order_item.valid?
  end
end
