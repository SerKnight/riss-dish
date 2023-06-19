# == Schema Information
#
# Table name: order_items
#
#  id         :bigint           not null, primary key
#  comments   :text
#  price      :decimal(, )
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_order_items_on_order_id    (order_id)
#  index_order_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :order_items, partial: "order_items/index", locals: {order_item: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :order_items, target: dom_id(self, :index) }
end
