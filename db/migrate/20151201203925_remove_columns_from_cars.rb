class RemoveColumnsFromCars < ActiveRecord::Migration
  def change
    remove_column :cars, :name, :string
    remove_column :cars, :price, :string
    remove_column :cars, :brand, :string
  end
end
