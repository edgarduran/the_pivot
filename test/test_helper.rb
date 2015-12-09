require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'mocha/mini_test'

module CategoryItemsSetup
  def create_locations
    locations = [Location.create(name: 'Capitol Hill'),
                 Location.create(name: 'Five Points'),
                 Location.create(name: 'Highland'),
                 Location.create(name: 'Five Points'),
                 Location.create(name: 'Lodo'),
                 Location.create(name: 'Washington Park')]
  end

  def add_car_to_cart
    create_cars(1)
    visit cars_path

    click_button 'Drive'
  end

  def create_cars(num)
    store     = Store.create(name: "Dave's Cars")
    store.users << User.create(username: "Dave", password: "cars")
    locations = [Location.create(name: 'Capitol Hill'),
                 Location.create(name: 'Five Points')]

    num.times do |i|
      store.cars.create( make: "Chevy#{i}",
                         model: "El Camino#{i}",
                         year: "196#{i}",
                         daily_price: 100 + i,
                         weekly_price: 600 + i,
                         description: "Dave met his wife ##{i} in this car.",
                         location_id: locations[i % 2].id)
    end
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

  def create_store_admin
    store = Store.create(name: "Dave's Cars")
    admin = User.create(username: 'Dave',
                        password: 'pw')

    admin.roles.create(name: 'store_admin')
    store.users << admin
  end

  def login_store_admin
    create_store_admin
    Store.first.update(approved: true)

    visit login_path

    fill_in 'Username', with: 'Dave'
    fill_in 'Password', with: 'pw'
    click_button 'Login'
  end

  def create_registered_user
    user = User.create(username: 'user',
                       password: 'password')

    user.roles.create(name: 'registered_user')
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

  def create_user_order(num, status = "pending")
    create_cars(1)
    current_user = User.first

    num.times do
      current_user_order = current_user.orders.create(current_status: status)
      current_user_order.order_items.create(car_id: Car.first.id,
                                            order_id: current_user_order.id,
                                            store_id: Store.first.id,
                                            user_id: current_user.id,
                                            days: 2)
    end
  end

  def create_business_approval_request
    login_user

    click_link "Lend a Car"

    fill_in "Name", with: "Matt's Cars"
    click_button "Request business approval"
  end

  def create_and_deactivate_store
    create_store_admin
    login_platform_admin

    visit stores_path

    click_link "Deactivate"
  end

  def logout_user
    click_link "Logout"
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
