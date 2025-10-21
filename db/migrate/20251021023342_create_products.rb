class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :discount_percentage
      t.integer :stock_quantity
      t.decimal :rating
      t.string :type
      t.boolean :loved
      t.datetime :deal_end_time
      t.boolean :in_stock
      t.boolean :on_sale
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end

  def change
    change_column_default :products, :rating, from: nil, to: 0
  end
end
