require "application_system_test_case"

class SlotsTest < ApplicationSystemTestCase
  setup do
    @slot = slots(:one)
  end

  test "visiting the index" do
    visit slots_url
    assert_selector "h1", text: "Slots"
  end

  test "creating a Slot" do
    visit slots_url
    click_on "New Slot"

    fill_in "Available additions", with: @slot.available_additions
    fill_in "Available entrees", with: @slot.available_entrees
    fill_in "Day", with: @slot.day_id
    fill_in "Delivery end time", with: @slot.delivery_end_time
    fill_in "Delivery start time", with: @slot.delivery_start_time
    click_on "Create Slot"

    assert_text "Slot was successfully created"
    assert_selector "h1", text: "Slots"
  end

  test "updating a Slot" do
    visit slot_url(@slot)
    click_on "Edit", match: :first

    fill_in "Available additions", with: @slot.available_additions
    fill_in "Available entrees", with: @slot.available_entrees
    fill_in "Day", with: @slot.day_id
    fill_in "Delivery end time", with: @slot.delivery_end_time
    fill_in "Delivery start time", with: @slot.delivery_start_time
    click_on "Update Slot"

    assert_text "Slot was successfully updated"
    assert_selector "h1", text: "Slots"
  end

  test "destroying a Slot" do
    visit edit_slot_url(@slot)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Slot was successfully destroyed"
  end
end
