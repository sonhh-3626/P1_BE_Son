class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :coupon, null: true, foreign_key: true
      t.decimal :subtotal
      t.decimal :applied_discount
      t.decimal :final_total
      t.boolean :is_free_shipping
      t.datetime :order_date

      t.timestamps
    end
  end
end
