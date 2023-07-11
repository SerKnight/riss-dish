class AddTagsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :tags, :string, array: true, default: []
  end
end
