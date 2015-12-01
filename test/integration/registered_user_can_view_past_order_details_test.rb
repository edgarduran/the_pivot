require 'test_helper'

class RegisteredUserCanViewPastOrderDetailsTest < ActionDispatch::IntegrationTest
  test 'user can view past order details' do
    create_categories_and_items
    current_user = User.create(username: 'Matt', password: 'gnargnar')
    visit login_path

    within('.login_form') do
      fill_in 'Username', with: 'Matt'
      fill_in 'Password', with: 'gnargnar'
      click_button 'Login'
    end

    order = current_user.orders.create(current_status: 'ordered',
                                       total_price: 1335)

    order.order_items.create(item_id: Item.first.id, order_id: order.id, quantity: 2)

    visit '/orders'

    click_link 'View Order'

    assert_equal order_path(order), current_path
    assert page.has_content?('Order Number')
    assert page.has_content?('Order Status')
    assert page.has_content?('Total')
    assert page.has_content?('Submitted on')

    within('.orders-table') do
      assert page.has_content?('Gnar possum')
      assert page.has_content?('$1000')
      assert page.has_content?('$2000')
      assert page.has_content?('2')
    end
  end

  test 'user can view past order details for multiple items' do
    create_categories_and_items
    current_user = User.create(username: 'Matt', password: 'gnargnar')
    visit login_path

    within('.login_form') do
      fill_in 'Username', with: 'Matt'
      fill_in 'Password', with: 'gnargnar'
      click_button 'Login'
    end

    order = current_user.orders.create(current_status: 'ordered',
                                       total_price: 1335)

    order.order_items.create(item_id: Item.first.id, order_id: order.id, quantity: 2)
    order.order_items.create(item_id: Item.last.id, order_id: order.id, quantity: 10)

    visit '/orders'

    click_link 'View Order'

    assert_equal order_path(order), current_path
    assert page.has_content?('Order Number')
    assert page.has_content?('Order Status')
    assert page.has_content?('Total')
    assert page.has_content?('Submitted on')

    within('.orders-table') do
      assert page.has_content?('Gnar possum')
      assert page.has_content?('Hoody')
      assert page.has_content?('$1000')
      assert page.has_content?('$80')
      assert page.has_content?('10')
      assert page.has_content?('$2800')
    end
  end
end
