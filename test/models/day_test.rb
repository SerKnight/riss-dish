# == Schema Information
#
# Table name: days
#
#  id          :bigint           not null, primary key
#  date        :datetime
#  description :text
#  is_locked   :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class DayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
