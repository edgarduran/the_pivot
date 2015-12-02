require 'test_helper'

class AVisitorCanViewItemsByCategoryTest < ActionDispatch::IntegrationTest
  test 'a visitor can visit category page to see all items in category' do
    create_categories_and_cars

    visit category_path(@category.slug)

    assert page.has_content?('Snowboards')

    within('.items') do
      assert page.has_content?('GNAR POSSUM')
      assert page.has_content?("A snowboard for shredding gnar
                               pow")
      assert page.has_content?('Price: $1000')
      assert page.has_content?('GWAR POSSUM')
      assert page.has_content?('A snowboard for gwar concerts')
      assert page.has_content?('Price: $15')
      refute page.has_content?('Apparel')
      refute page.has_content?('SWEET JACKET')
      refute page.has_content?('Keeps you warm')
      refute page.has_content?('Price: $240')
      refute page.has_content?('HOODY')
      refute page.has_content?('Keeps you slightly warm')
      refute page.has_content?('Price: $80')
    end

    visit category_path(@category_two.slug)

    assert page.has_content?('Apparel')

    within('.items') do
      assert page.has_content?('SWEET JACKET')
      assert page.has_content?('Keeps you warm')
      assert page.has_content?('Price: $240')
      assert page.has_content?('HOODY')
      assert page.has_content?('Keeps you slightly warm')
      assert page.has_content?('Price: $80')
      refute page.has_content?('Snowboards')
      refute page.has_content?('GNAR POSSUM')
      refute page.has_content?("A snowboard for shredding gnar
                               pow")
      refute page.has_content?('Price: $1000')
      refute page.has_content?('GWAR POSSUM')
      refute page.has_content?('A snowboard for gwar concerts')
      refute page.has_content?('Price: $15')
    end
  end
end
