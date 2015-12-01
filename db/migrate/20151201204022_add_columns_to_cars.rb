class AddColumnsToCars < ActiveRecord::Migration
  def change
    add_column :cars, :model, :string
    add_column :cars, :make, :string
    add_column :cars, :year, :string
    add_column :cars, :daily_price, :integer
    add_column :cars, :weekly_price, :integer
  end
end
