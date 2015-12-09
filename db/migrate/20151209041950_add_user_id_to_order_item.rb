class AddUserIdToOrderItem < ActiveRecord::Migration
  def change
    add_reference :order_items, :user, index: true, foreign_key: true
  end
end
