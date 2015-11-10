require 'test_helper'

class AVisitorCanViewItemsByCategoryTest < ActionDispatch::IntegrationTest
  test 'a visitor can visit category page to see all items in category' do

    category     = Category.create(title: "Snowboards")
    category_two = Category.create(title: "Apparel")

    Item.create(name: "gnar possum",
                       description: "a snowboard for shredding gnar pow",
                       price: 1000,
                       category_id: category.id)
    Item.create(name: "gwar possum",
                       description: "a snowboard for gwar concerts",
                       price: 15,
                       category_id: category.id)
    Item.create(name: "Sweet Jacket",
                       description: "Keeps you warm",
                       price: 240,
                       category_id: category_two.id)
    Item.create(name: "Hoody",
                       description: "Keeps you slightly warm",
                       price: 80,
                       category_id: category_two.id)

    visit category_path(category)

    assert page.has_content?("Snowboards")
    assert page.has_content?("Name: GNAR POSSUM")
    assert page.has_content?("Description: A snowboard for shredding gnar pow")
    assert page.has_content?("Price: $1000")
    assert page.has_content?("Name: GWAR POSSUM")
    assert page.has_content?("Description: A snowboard for gwar concerts")
    assert page.has_content?("Price: $15")


    visit category_path(category_two)

    assert page.has_content?("Apparel")
    assert page.has_content?("Name: SWEET JACKET")
    assert page.has_content?("Keeps you warm")
    assert page.has_content?("Price: $240")
    assert page.has_content?("Name: HOODY")
    assert page.has_content?("Keeps you slightly warm")
    assert page.has_content?("Price: $80")
  end

end
