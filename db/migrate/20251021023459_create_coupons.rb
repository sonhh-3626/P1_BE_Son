class CreateCoupons < ActiveRecord::Migration[8.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :discount_percentage
      t.decimal :min_amount
      t.boolean :free_shipping
      t.datetime :expires

      t.timestamps
    end
    add_index :coupons, :code, unique: true
  end
end
