require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'mocha/mini_test'

module CategoryItemsSetup
  def add_car_to_cart
    create_cars(1)
    visit cars_path

    click_link 'Add to my Garage'
  end

  def create_categories_cars_user_order_and_login
    create_cars(1)
    login_user

    current_user = User.first

    current_user_order = current_user.orders.create(current_status: 'ordered')
    current_user_order.order_items.create(car_id: Car.first.id,
                                          order_id: current_user_order.id,
                                          days: 2)
  end

  def create_cars(num)
    store     = Store.create(name: "Dave's Cars")
    locations = [Location.create(name: 'Capitol Hill'),
                 Location.create(name: 'Five Points')]

    num.times do |i|
      store.cars.create( make: "Chevy#{i}",
                         model: "El Camino#{i}",
                         year: "196#{i}",
                         daily_price: 100 + i,
                         weekly_price: 600 + i,
                         description: "Dave met his wife ##{i} in this car.",
                         image: File.open('app/assets/images/gnar_possum.jpg'),
                         location_id: locations[i % 2].id
                       )
    end
  end

  def create_items_and_order
    category     = Category.create(title: 'Snowboards')
    category_two = Category.create(title: 'Apparel')
    create_cars(3)
    Order.create(current_status: 'completed')
  end

  def create_user
    user = User.create(username: 'Matt',
                       password: 'gnargnar',
                       email: 'matthewjrooney@gmail.com')

    user.roles.create(name: 'registered_user')
  end

  def login_user
    create_user
    visit login_path

    fill_in 'Username', with: 'Matt'
    fill_in 'Password', with: 'gnargnar'
    click_button 'Login'
  end

  def create_and_login_additional_user
    user = User.create(username: "Molly",
                       password: "password",
                       email: "molly@coolcars.com")

    user.roles.create(name: 'registered_user')

    visit login_path
    fill_in 'Username', with: 'Molly'
    fill_in 'Password', with: 'password'
    click_button 'Login'
  end

  def create_platform_admin
    admin = User.create(username: 'platform admin',
                        password: 'password')
    role =  Role.create(name: 'platform_admin')
    admin.roles << role
  end

  def create_store_admin
    admin = User.create(username: 'store admin',
                        password: 'password')
    role =  Role.create(name: 'store_admin')
    admin.roles << role
  end

  def create_registered_user
    user = User.create(username: 'user',
                        password: 'password')
    role =  Role.create(name: 'regitered_user')
    user.roles << role
  end

  def add_items_to_cart
    item_1 = Car.create
    item_2 = Car.create
    item_3 = Car.create

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

  def create_user_order(num)
    create_cars(1)
    current_user = User.first

    num.times do
      current_user_order = current_user.orders.create(current_status: 'ordered')
      current_user_order.order_items.create(car_id: Car.first.id,
                                            order_id: current_user_order.id,
                                            days: 2)
    end
  end

  def create_and_login_additional_users(num)
    num.times do |i|
      i += 1
      user = User.create(username: "name#{i}", password: "password#{i}")
    end

    visit login_path
    fill_in 'Username', with: "user.username"
    fill_in 'Password', with: "user.password"
    click_button 'Login'
  end

  def admin_order_setup(status)
    admin = User.create(username: 'admin',
                        password: 'password',
                        role:      1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    create_categories_and_cars
    order = Order.create(current_status: status)
    order_item = OrderItem.new(item_id: Car.last.id, order_id: order.id, quantity: 2)
    order.order_items << order_item
    order.save

    visit login_path

    fill_in 'Username', with: 'admin'
    fill_in 'Password', with: 'password'
    click_button 'Login'
  end

  def create_platform_admin
    admin = User.create(username: 'admin',
                        password: 'password')

    admin.roles.create(name: "platform_admin")
  end

  def login_platform_admin
    create_platform_admin

    visit login_path

    fill_in 'Username', with: 'admin'
    fill_in 'Password', with: 'password'
    click_button 'Login'
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include CategoryItemsSetup

  def teardown
    reset_session!
  end
end

class ActiveSupport::TestCase
  include CategoryItemsSetup
end
