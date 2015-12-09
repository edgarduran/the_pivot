class AddStoreIdToOrderItems < ActiveRecord::Migration
  def change
    add_reference :order_items, :store, index: true, foreign_key: true
  end
end
