require 'test_helper'

class UserCanViewPastOrdersTest < ActionDispatch::IntegrationTest
  test 'user can view one past order' do
    create_categories_and_items
    current_user = User.create(username: 'Matt', password: 'gnargnar')
    visit login_path

    within('.login_form') do
      fill_in 'Username', with: 'Matt'
      fill_in 'Password', with: 'gnargnar'
      click_button 'Login'
    end

    order = current_user.orders.create(current_status: 'ordered')

    order.order_items.create(item_id: Item.first.id, order_id: order.id, quantity: 2)

    visit '/orders'

    assert page.has_content?('Your Orders')
    assert page.has_content?('ordered')
  end

  test 'user can view a list of all past orders' do
    create_categories_and_items
    current_user = User.create(username: 'Matt', password: 'gnargnar')
    visit login_path

    within('.login_form') do
      fill_in 'Username', with: 'Matt'
      fill_in 'Password', with: 'gnargnar'
      click_button 'Login'
    end

    order = current_user.orders.create(current_status: 'completed')
    order = current_user.orders.create(current_status: 'paid')

    order.order_items.create(item_id: Item.first.id, order_id: order.id, quantity: 2)

    visit '/orders'

    assert page.has_content?('Your Orders')
    assert page.has_content?('completed')
    assert page.has_content?('paid')
  end
end
