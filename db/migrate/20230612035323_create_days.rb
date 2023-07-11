class CreateDays < ActiveRecord::Migration[7.0]
  def change
    create_table :days do |t|
      t.text :description
      t.datetime :date
      t.boolean :is_locked

      t.timestamps
    end
  end
end
