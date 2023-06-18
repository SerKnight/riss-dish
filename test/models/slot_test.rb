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
require "test_helper"

class SlotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
