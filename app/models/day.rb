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
class Day < ApplicationRecord
  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :days, partial: "days/index", locals: {day: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :days, target: dom_id(self, :index) }

  has_many :day_products
  has_many :products, through: :day_products
  has_many :slots
  belongs_to :primary_product, class_name: "Product", optional: true

  after_save :create_default_slots

  def main_product
    Product.find(self.primary_product_id)
  end

  def backup_products
    Product.where(id: self.product_ids)
  end

  def open_slots
    all_slots = self.slots # Get all slots for the day
    completed_order_slots = Order.where(slot_id: all_slots.pluck(:id)).where(completed: true) # Get slots of completed orders
    all_slots.where.not(id: completed_order_slots.pluck(:slot_id)) # Return the slots that have not been attached to a completed order
  end
  

  private

  def create_default_slots
    if self.slots.empty?
      Time.use_zone('Mountain Time (US & Canada)') do
    
        # 4-5PM slots
        4.times do |i|
          delivery_start = self.date.change(hour: 16, min: 0)
          delivery_end = self.date.change(hour: 17, min: 0)
    
          self.slots.create(
            delivery_start_time: delivery_start,
            delivery_end_time: delivery_end,
            available_additions: default_additions,
            available_entrees: default_entrees
          )
        end
    
        # 5-6PM slots
        4.times do |i|
          delivery_start = self.date.change(hour: 17, min: 0)
          delivery_end = self.date.change(hour: 18, min: 0)
    
          self.slots.create(
            delivery_start_time: delivery_start,
            delivery_end_time: delivery_end,
            available_additions: default_additions,
            available_entrees: default_entrees
          )
        end
      end
    end
  end

  def default_additions
    6
  end

  def default_entrees
    8
  end
end
