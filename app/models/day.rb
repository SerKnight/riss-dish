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
class Day < ApplicationRecord
  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :days, partial: "days/index", locals: {day: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :days, target: dom_id(self, :index) }

  has_many :day_products
  has_many :products, through: :day_products
  has_many :slots

  after_update :create_default_slots

  private

  def create_default_slots
    8.times do |i|
      self.slots.create(
        delivery_start_time: (self.date + i.hours), 
        delivery_end_time: (self.date + (i+4).hours),
        available_additions: default_additions, 
        available_entrees: default_entrees
      )
    end
  end

  def default_additions
    10
  end

  def default_entrees
    8
  end
end
