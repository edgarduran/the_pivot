require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test 'items are asscociated wit an order' do
    create_items
    order = Order.new(current_status: 'completed')
    order_item = OrderItem.new(item_id: Item.last.id, order_id: order.id, quantity: 2)
    order.order_items << order_item
    order.save

    assert order.valid?
    assert order_item.valid?
  end
end
