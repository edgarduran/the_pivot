class AddActivatedToStore < ActiveRecord::Migration
  def change
    add_column :stores, :activated, :boolean, :default => true
  end
end
