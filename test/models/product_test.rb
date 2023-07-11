# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  ingredients :text
#  price       :decimal(, )
#  tags        :string           default([]), is an Array
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
