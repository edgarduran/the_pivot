class AddApprovedToStore < ActiveRecord::Migration
  def change
    add_column :stores, :approved, :boolean, :default => false
  end
end
