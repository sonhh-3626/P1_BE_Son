class ChangeDefaultsForOrders < ActiveRecord::Migration[7.1]
  def change
    change_column_default :orders, :subtotal, from: nil, to: 0.0
    change_column_default :orders, :final_total, from: nil, to: 0.0
  end
end
