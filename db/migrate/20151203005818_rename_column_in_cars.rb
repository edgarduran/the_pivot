class RenameColumnInCars < ActiveRecord::Migration
  def change
    rename_column :cars, :category_id, :location_id
  end
end
