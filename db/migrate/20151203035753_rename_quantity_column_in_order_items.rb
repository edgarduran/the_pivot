class RenameQuantityColumnInOrderItems < ActiveRecord::Migration
  def change
    rename_column :order_items, :quantity, :days
  end
end
