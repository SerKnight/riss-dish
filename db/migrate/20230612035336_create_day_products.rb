class CreateDayProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :day_products do |t|
      t.references :day, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
