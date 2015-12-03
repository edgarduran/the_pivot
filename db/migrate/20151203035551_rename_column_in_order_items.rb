class RenameColumnInOrderItems < ActiveRecord::Migration
  def change
    rename_column :order_items, :item_id, :car_id
  end
end
