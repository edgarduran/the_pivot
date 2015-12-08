require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test 'has initial contents' do
    cart = Cart.new('1' => 1)

    assert_equal({ '1' => 1 }, cart.contents)
  end

  test 'can add an item' do
    cart = Cart.new('1' => 1)

    cart.add_car(1)
    cart.add_car(2)

    assert_equal({ '1' => 2, '2' => 1 }, cart.contents)
  end

  test 'returns total number of cart items' do
    cart = Cart.new('1' => 3, '2' => 1, '3' => 3)

    assert_equal 7, cart.total
  end

  test 'returns total number of specific item' do
    cart = Cart.new('1' => 3, '2' => 1, '3' => 3)

    assert_equal 3, cart.count_of(3)
  end
end
