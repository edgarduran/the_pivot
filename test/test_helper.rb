ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'mocha/mini_test'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module CategoryItemsSetup
  def create_categories_and_items
    @category     = Category.create(title: 'Snowboards')
    @category_two = Category.create(title: 'Apparel')

    Item.create(name: 'gnar possum',
                description: 'a snowboard for shredding gnar pow',
                price: 1000,
                category_id: @category.id)
    Item.create(name: 'gwar possum',
                description: 'a snowboard for gwar concerts',
                price: 15,
                category_id: @category.id)
    Item.create(name: 'Sweet Jacket',
                description: 'Keeps you warm',
                price: 240,
                category_id: @category_two.id)
    Item.create(name: 'Hoody',
                description: 'Keeps you slightly warm',
                price: 80,
                category_id: @category_two.id)
  end

  def create_items
    Item.create(name: 'gnar possum',
                description: 'a snowboard for shredding gnar pow',
                price: 1000)
    Item.create(name: 'gwar possum',
                description: 'a snowboard for gwar concerts',
                price: 15)
  end

  def create_items_and_order
    @category     = Category.create(title: 'Snowboards')
    @category_two = Category.create(title: 'Apparel')
    item_1 = Item.create(name: 'gnar possum',
                         description: 'a snowboard for shredding gnar pow',
                         price: 1000,
                         category_id: @category.id)
    item_2 = Item.create(name: 'gwar possum',
                         description: 'a snowboard for gwar concerts',
                         price: 15,
                         category_id: @category.id)
    item_3 = Item.create(name: 'Hoody',
                         description: 'Keeps you slightly warm',
                         price: 80,
                         category_id: @category_two.id)
    Order.create(current_status: 'completed')
  end

  def create_items_associated_with_orders
    create_categories_and_items
    order   = Order.create(current_status: 'completed')
    order_2 = Order.create(current_status: 'completed')
    order_3 = Order.create(current_status: 'paid')
    order_4 = Order.create(current_status: 'canceled')
    order_5 = Order.create(current_status: 'ordered')
    order_item = OrderItem.new(item_id: Item.last.id, order_id: order.id, quantity: 2)
    order.order_items << order_item
    order.save
  end

  def create_user
    User.create(username: 'Matt',
                password: 'gnargnar',
                email: 'matthewjrooney@gmail.com')
  end

  def login_a_user
    create_user
    visit login_path

    within('.login_form') do
      fill_in 'Username', with: 'Matt'
      fill_in 'Password', with: 'gnargnar'
      click_button 'Login'
    end
  end

  def add_items_to_cart
    item_1 = Item.create(name: 'gnar possum',
                         description: 'a snowboard for shredding gnar pow',
                         price: 1000)
    item_2 = Item.create(name: 'gnar possum',
                         description: 'a snowboard for shredding gnar pow',
                         price: 1000)
    item_3 = Item.create(name: 'Sweet Jacket',
                         description: 'Keeps you warm',
                         price: 240)

    visit items_path
    within("#item_#{item_1.id}") do
      click_link 'Add To Cart'
    end
    within("#item_#{item_2.id}") do
      click_link 'Add To Cart'
    end
    within("#item_#{item_3.id}") do
      click_link 'Add To Cart'
    end
  end

  def create_categories_items_user_order_and_login
    create_categories_and_items
    current_user = User.create(username: 'Matt', password: 'gnargnar')
    visit login_path

    within('.login_form') do
      fill_in 'Username', with: 'Matt'
      fill_in 'Password', with: 'gnargnar'
      click_button 'Login'
    end

    current_user_order = current_user.orders.create(current_status: 'ordered')
    current_user_order.order_items.create(item_id: Item.first.id,
                                          order_id: current_user_order.id,
                                          quantity: 2)
  end

  def create_and_login_additional_users(num)
    id = 0
    num.times do
      id += 1
      User.create(username: "name#{id}", password: "password#{id}")
    end
    visit login_path

    within('.login_form') do
      fill_in 'Username', with: "name#{id}"
      fill_in 'Password', with: "password#{id}"
      click_button 'Login'
    end
  end

  def admin_order_setup(status)
    admin = User.create(username: 'admin',
                        password: 'password',
                        role:      1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    create_categories_and_items
    order = Order.create(current_status: status)
    order_item = OrderItem.new(item_id: Item.last.id, order_id: order.id, quantity: 2)
    order.order_items << order_item
    order.save

    visit login_path

    fill_in 'Username', with: 'admin'
    fill_in 'Password', with: 'password'
    click_button 'Login'
  end

  def create_featured_car
    @featured_item = Item.create({ name: 'gnar possum',
                                   description: 'a snowboard for shredding gnar',
                                   price: 1000,
                                   brand: 'Jibberish',
                                   image: File.open('app/assets/images/gnar_possum.jpg')
                          })
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL


  def teardown
    reset_session!
  end
end
