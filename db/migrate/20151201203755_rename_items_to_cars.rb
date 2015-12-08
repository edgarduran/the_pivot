class RenameItemsToCars < ActiveRecord::Migration
  def change
    rename_table :items, :cars
  end
end
