# == Schema Information
#
# Table name: day_products
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  day_id     :bigint           not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_day_products_on_day_id      (day_id)
#  index_day_products_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (day_id => days.id)
#  fk_rails_...  (product_id => products.id)
#
class DayProduct < ApplicationRecord
  belongs_to :day
  belongs_to :product
  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :day_products, partial: "day_products/index", locals: {day_product: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :day_products, target: dom_id(self, :index) }
end
