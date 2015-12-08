class AddStoreIdtoCar < ActiveRecord::Migration
  def change
    add_reference :cars, :store, index: true, foreign_key: true
  end
end
