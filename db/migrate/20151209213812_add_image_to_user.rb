class AddImageToUser < ActiveRecord::Migration
  def change
    add_column :users, :image, :string, default: "http://buira.org/assets/images/shared/default-profile.png"
  end
end
