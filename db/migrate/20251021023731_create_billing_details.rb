class CreateBillingDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :billing_details do |t|
      t.references :order, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :country_region
      t.string :street_address
      t.string :apartment_suite
      t.string :town_city
      t.string :state
      t.string :zip_code
      t.string :phone
      t.string :email
      t.text :order_notes

      t.timestamps
    end
  end
end
