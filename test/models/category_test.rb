require 'test_helper'

class CategoryTest < ActiveSupport::TestCase


  test 'a location with all attributes is valid' do
    location = Location.new(name: 'Five Points')

    assert location.valid?
  end

  test 'a location without a name is invalid' do
    location = Location.new(name: '')

    refute location.valid?
  end

  test 'a location has cars' do
    create_cars(4)
    location  = Location.first
    location2 = Location.last

    assert_equal 2, location.cars.count
    assert_equal 2, location2.cars.count
    assert_equal "1960 Chevy0 El Camino0", location.cars.first.full_name
    assert_equal "1961 Chevy1 El Camino1", location2.cars.first.full_name
  end
end
