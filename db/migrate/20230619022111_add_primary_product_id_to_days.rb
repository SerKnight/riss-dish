class AddPrimaryProductIdToDays < ActiveRecord::Migration[7.0]
  def change
    add_reference :days, :primary_product, foreign_key: { to_table: :products }
  end
end
