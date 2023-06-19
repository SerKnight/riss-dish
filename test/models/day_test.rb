# == Schema Information
#
# Table name: days
#
#  id                 :bigint           not null, primary key
#  date               :datetime
#  description        :text
#  is_locked          :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  primary_product_id :bigint
#
# Indexes
#
#  index_days_on_primary_product_id  (primary_product_id)
#
# Foreign Keys
#
#  fk_rails_...  (primary_product_id => products.id)
#
require "test_helper"

class DayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
