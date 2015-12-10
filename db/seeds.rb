class Seed
  def self.start
    seed = Seed.new
    seed.generate_platform_admin
    seed.generate_stores
    seed.generate_locations_and_cars
    seed.generate_users
    seed.generate_orders
  end

  def generate_platform_admin
    user = User.create!(username: "jorge@turing.io",
                        password: "password")

    user.roles.create!(name: "platform_admin")

    puts "Platform admin created as 'jorge@turing.io'! =O"
  end

  def generate_stores
    19.times do |i|
      user = User.create!(username: "storeadmin#{i+1}",
                          password: "password")

      user.roles.create!(name: "store_admin")

      store = Store.create!(name: "#{Faker::Company.name} Cars")
      store.users << user

      puts "Store #{i+1} (#{store.name}) created!"
    end

    generate_andrews_store
  end

  def generate_locations_and_cars
    locations = denver_neighbourhoods
    images = car_images
    puts "Creating cars... be patient :) "

    Store.all.each_with_index do |store, i|
      35.times do |i|
        car = store.cars.create!(make: Faker::Commerce.product_name,
                                 model: Faker::Name.first_name,
                                 year: Faker::Number.between(from = 1900, to = 2015),
                                 description: Faker::Hipster.paragraph,
                                 location_id: locations[i % 12].id,
                                 daily_price: Faker::Commerce.price(range = 50..100),
                                 image: images[i % 7])

        # puts "Car #{i+1} (#{car.full_name}) created!"
      end
      puts "35 cars created for #{store.name}. Total cars: #{(i+1) * 35}"
    end
  end

  def generate_users
    99.times do |i|
      user = User.create!(username: Faker::Internet.user_name,
                          password: Faker::Internet.password)

      puts "User #{i+1}: #{user.username} created!"
    end

    User.create!(username: "josh@turing.io",
                 password: "password")

    puts "User 'josh@turing.io' has been created! =O"
  end

  def generate_orders
    car_count = Car.count

    User.all.each_with_index do |user, n|
      10.times do |i|
        order = Order.create!(user_id: user.id)
        car = Car.find(rand(1..car_count))

        order.order_items.create!( user_id: user.id,
                                   store_id: car.store.id,
                                   days: 2,
                                   car_id: car.id )

        puts "Order #{(i+1) * (n+1)}: Order for #{user.username} created!"
      end
    end
  end

  private

    def generate_andrews_store
      user = User.create!(username: "andrew@turing.io",
                          password: "password")

      user.roles.create!(name: "store_admin")

      store = Store.create!(name: "#{Faker::Company.name} Cars")
      store.users << user

      puts "Store 20 (#{store.name}) created for Andrew! =O"
    end

    def car_images
      [ "https://images.unsplash.com/photo-1444598664632-8403d0237760?crop=entropy&dpr=0.67&fit=crop&fm=jpg&h=1175&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=2175",
        "https://images.unsplash.com/photo-1441148345475-03a2e82f9719?crop=entropy&dpr=0.67&fit=crop&fm=jpg&h=1175&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=2175",
        "https://images.unsplash.com/photo-1417444419095-aae558146a39?crop=entropy&dpr=0.67&fit=crop&fm=jpg&h=1175&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=2175",
        "https://images.unsplash.com/12/car.jpg?crop=entropy&dpr=0.67&fit=crop&fm=jpg&h=1175&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=2175",
        "https://images.unsplash.com/19/bad-ass.JPG?crop=entropy&dpr=0.67&fit=crop&fm=jpg&h=1175&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=2175",
        "https://images.unsplash.com/photo-1446891549729-620bb632b9d1?crop=entropy&dpr=0.67&fit=crop&fm=jpg&h=1175&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=2175",
        "https://images.unsplash.com/uploads/1413686514683468a35c4/bcccfd71?crop=entropy&dpr=0.67&fit=crop&fm=jpg&h=1175&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=2175",
        "https://images.unsplash.com/photo-1445098344978-4080e28b6355?crop=entropy&dpr=0.67&fit=crop&fm=jpg&h=1175&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=2175" ]
    end

    def denver_neighbourhoods
      [ Location.create(name: 'Auraria'),
        Location.create(name: 'Baker'),
        Location.create(name: 'Capitol Hill'),
        Location.create(name: 'City Park'),
        Location.create(name: 'Cheeseman Park'),
        Location.create(name: 'Cherry Creek'),
        Location.create(name: 'Five Points'),
        Location.create(name: 'Highlands'),
        Location.create(name: 'Lodo'),
        Location.create(name: 'RiNo'),
        Location.create(name: 'Speer'),
        Location.create(name: 'Uptown') ]
     end
end

Seed.start
