class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.references :day, null: false, foreign_key: true
      t.datetime :delivery_start_time
      t.datetime :delivery_end_time
      t.integer :available_additions
      t.integer :available_entrees

      t.timestamps
    end
  end
end
