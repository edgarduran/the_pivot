class AddStoreIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :store, index: true, foreign_key: true
  end
end
