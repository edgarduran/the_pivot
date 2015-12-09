class AddAboutToStores < ActiveRecord::Migration
  def change
    add_column :stores, :about, :text
  end
end
