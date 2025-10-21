class RemoveTypeFromProducts < ActiveRecord::Migration[8.0]
  def change
    remove_column :products, :type, :string
  end
end
