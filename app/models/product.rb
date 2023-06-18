# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  ingredients :text
#  price       :decimal(, )
#  tags        :string           default([]), is an Array
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :products, partial: "products/index", locals: {product: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :products, target: dom_id(self, :index) }

  has_one_attached :main_image
  has_many_attached :images
end
