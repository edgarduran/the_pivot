class AddImageToCars < ActiveRecord::Migration
  def change
    add_column :cars, :image, :string, default: "car_default.png"
  end
end
