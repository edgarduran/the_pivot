require_relative "../test/test_helper.rb"

class Seed
  def self.start
    seed = Seed.new
    seed.generate_platform_admin
    seed.generate_users
    seed.generate_items
    # seed.generate_orders
  end

  def generate_platform_admin
    user = User.create!(username: "admin",
                        password: "password")

    user.roles.create!(name: "platform_admin")

    puts "Platform admin created (username: admin, password: password)!"
  end

  def generate_users
    50.times do |i|
      user = User.create!(username: Faker::Internet.user_name,
                          password: Faker::Internet.password)

      puts "User #{i}: #{user.username} created!"
    end
  end

  def generate_items
    store = Store.create!(name: "Cars-o-rama")
    500.times do |i|
      car = store.cars.create!(make: Faker::Commerce.product_name,
                               model: Faker::Name.first_name,
                               year: Faker::Number.between(from = 1900, to = 2015),
                               description: Faker::Hipster.paragraph,
                               daily_price: Faker::Commerce.price(range = 50..100))

      puts "Car #{i}: #{car.full_name} created!"
    end
  end

  # def generate_orders
  #   100.times do |i|
  #     user  = User.find(Random.new.rand(1..50))
  #     order = Order.create!(user_id: user.id)
  #     add_items(order)
  #     puts "Order #{i}: Order for #{user.name} created!"
  #   end
  # end
  #
  # private
  #
  # def add_items(order)
  #   10.times do |i|
  #     item = Item.find(Random.new.rand(1..500))
  #     order.items << item
  #     puts "#{i}: Added item #{item.name} to order #{order.id}."
  #   end
  # end
end

Seed.start
