class AddMusicChargeToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :music_charge, :decimal, precision: 8, scale: 2
  end
end
