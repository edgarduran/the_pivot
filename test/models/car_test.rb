require "test_helper"

class CarTest < ActiveSupport::TestCase
  test "a new car with all attributes is valid" do
    car = Car.new(model: "El Camino",
                  make: "Chevy",
                  year: 1978,
                  description: "A car",
                  daily_price: 100,
                  weekly_price: 600,
                  location_id: 1,
                  store_id: 1,
                  image_file_name: "hi.png")

    assert car.valid?
  end

  test "it cannot create a new car without a model" do
    car = Car.new(make: "Chevy",
                  year: 1978,
                  description: "A car",
                  daily_price: 100,
                  weekly_price: 600,
                  location_id: 1,
                  store_id: 1,
                  image_file_name: "hi.png")

    refute car.valid?
  end

  test "it cannot create a new car without a make" do
    car = Car.new(model: "Chevy",
                  year: 1978,
                  description: "A car",
                  daily_price: 100,
                  weekly_price: 600,
                  location_id: 1,
                  store_id: 1,
                  image_file_name: "hi.png")

    refute car.valid?
  end

  test "it cannot create a new car without a year" do
    car = Car.new(model: "El Comanio",
                  make: "Chevy",
                  description: "A car",
                  daily_price: 100,
                  weekly_price: 600,
                  location_id: 1,
                  store_id: 1,
                  image_file_name: "hi.png")

    refute car.valid?
  end

  test "it cannot create a new item without a daily price" do
    car = Car.new(model: "El Camino",
                  make: "Chevy",
                  year: 1978,
                  description: "A car",
                  location_id: 1,
                  store_id: 1,
                  image_file_name: "hi.png")

    refute car.valid?
  end

  test "it cannot create a new item with a price that is not an integer" do
    car = Car.new(model: "El Camino",
                  make: "Chevy",
                  year: 1978,
                  description: "A car",
                  daily_price: "hey",
                  location_id: 1,
                  store_id: 1,
                  image_file_name: "hi.png")

    refute car.valid?
  end

  test "it cannot create a new item with a year that is not an integer" do
    car = Car.new(model: "El Camino",
                  make: "Chevy",
                  year: "hey",
                  description: "A car",
                  daily_price: 100,
                  location_id: 1,
                  store_id: 1,
                  image_file_name: "hi.png")

    refute car.valid?
  end
end
