class ChangeDefaultCurrentStatusForOrders < ActiveRecord::Migration
  def change
    change_column_default(:orders, :current_status, 'pending')
  end
end
