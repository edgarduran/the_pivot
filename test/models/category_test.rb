require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  

  test 'a category with all attributes is valid' do
    category = Category.new(title: 'Snowboards')

    assert category.valid?
  end

  test 'a category without a title is invalid' do
    category = Category.new(title: '')

    refute category.valid?
  end

  test 'a category has items' do
    create_categories_and_cars

    assert_equal 2, @category.items.count
    assert_equal 2, @category_two.items.count
    assert_equal 'gnar possum', @category.items.first.name
    assert_equal 'Sweet Jacket', @category_two.items.first.name
  end
end
