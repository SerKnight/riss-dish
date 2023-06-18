# == Schema Information
#
# Table name: slots
#
#  id                  :bigint           not null, primary key
#  available_additions :integer
#  available_entrees   :integer
#  delivery_end_time   :datetime
#  delivery_start_time :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  day_id              :bigint           not null
#
# Indexes
#
#  index_slots_on_day_id  (day_id)
#
# Foreign Keys
#
#  fk_rails_...  (day_id => days.id)
#
class Slot < ApplicationRecord
  belongs_to :day
  has_one :orders

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :slots, partial: "slots/index", locals: {slot: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :slots, target: dom_id(self, :index) }
end
