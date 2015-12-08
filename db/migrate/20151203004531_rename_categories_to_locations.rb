class RenameCategoriesToLocations < ActiveRecord::Migration
  def change
    rename_table :categories, :locations
  end
end
