# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  completed         :boolean          default(FALSE)
#  music_charge      :decimal(8, 2)
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
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
