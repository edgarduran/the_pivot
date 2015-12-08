class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_car(car_id)
    contents[car_id.to_s] ||= 0
    contents[car_id.to_s] += 1
  end

  def total
    contents.values.sum
  end

  def count_of(car_id)
    contents[car_id.to_s]
  end

  def update_days(days, id)
    contents.select { |car, _days| car == id }
      .map do |car, _days|
      contents[car] = days.to_i
    end
  end

  def remove_cars(params)
    contents.delete_if { |car_id, _quantity| car_id == params[:id] }
  end

  def complete_cart
    {
      cars: cars,
      total_price: total_price
    }
  end

  def total_price
    contents.map do |car_id, quantity|
      Car.find(car_id.to_i).daily_price * quantity
    end
      .sum
  end

  def cars
    contents.map do |car_id, count|
      car = Car.find(car_id)
      CartItem.new(car, count)
    end
  end
end

class CartItem < SimpleDelegator
  attr_accessor :count

  def initialize(item, count)
    super(item)
    @count = count
  end
end
