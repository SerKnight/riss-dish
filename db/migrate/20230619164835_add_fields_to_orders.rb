class AddFieldsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :tupperware_charge, :decimal, precision: 8, scale: 2
    add_column :orders, :subtotal, :decimal, precision: 8, scale: 2
    add_column :orders, :tax, :decimal, precision: 8, scale: 2
    add_column :orders, :total, :decimal, precision: 8, scale: 2
  end
end
