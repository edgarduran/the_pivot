require 'test_helper'

class VisitorCannotViewOrdersAndAdminViewsTest < ActionDispatch::IntegrationTest
  include CategoryItemsSetup
  test 'an unauthenticated user cannot view any orders' do
    create_categories_items_user_order_and_login

    visit '/orders'

    assert page.has_content?('Your Orders')
    assert page.has_content?('ordered')

    click_link('View Order')
    within('.orders-table') do
      assert page.has_content?('$2000')
      assert page.has_content?('Gnar possum')
    end
    click_link('Logout')

    visit '/orders'

    assert page.has_content?('404')
  end

  test 'an unauthenticated user cannot view a users cart' do
    create_categories_items_user_order_and_login
    add_items_to_cart
    visit '/cart'

    within('.cart-count') do
      assert page.has_content?('3')
    end

    within('.left') do
      assert page.has_content?('$2240')
    end

    click_link('Logout')

    within('.cart-count') do
      assert page.has_content?('0')
    end

    visit '/cart'

    within('.cart-count') do
      refute page.has_content?('3')
    end

    within('.left') do
      refute page.has_content?('$2240')
    end
  end

  test 'an unauthenticated user cannot view a users dashboard' do
    create_categories_items_user_order_and_login
    add_items_to_cart
    old_user = User.find_by(username: 'Matt')
    click_link('Logout')

    visit "/users/#{old_user.id}"

    assert page.has_content?('404')
  end

  test 'an unauthenticated user cannot view admin dashboard' do
    admin = User.create(username: 'admin', password: 'admin_password', role: 1)
    create_featured_car
    visit '/'
    click_link('Login')

    fill_in 'Username', with: 'admin'
    fill_in 'Password', with: 'admin_password'
    click_button 'Login'

    visit '/admin/dashboard'

    assert page.has_content?('Welcome, Admin!')

    click_link('Logout')

    visit '/admin/dashboard'

    assert page.has_content?('404')
  end

  test 'a user cannot make themselves an admin' do
    create_and_login_additional_users(1)
    user = User.first

    visit '/admin/dashboard'

    assert page.has_content?('404')
  end
end
