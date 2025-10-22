class AddCreateAccountAndShipToDifferentAddressToBillingDetails < ActiveRecord::Migration[8.0]
  def change
    add_column :billing_details, :create_account, :boolean
    add_column :billing_details, :ship_to_a_different_address, :boolean
  end
end
