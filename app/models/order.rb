# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  completed         :boolean          default(FALSE)
#  subtotal          :decimal(8, 2)
#  tax               :decimal(8, 2)
#  total             :decimal(8, 2)
#  tupperware_charge :decimal(8, 2)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  slot_id           :bigint           not null
#  user_id           :bigint
#
# Indexes
#
#  index_orders_on_slot_id  (slot_id)
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (slot_id => slots.id)
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  has_many :order_items
  belongs_to :slot
  belongs_to :user, optional: true

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :orders, partial: "orders/index", locals: {order: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :orders, target: dom_id(self, :index) }
end
