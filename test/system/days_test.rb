require "application_system_test_case"

class DaysTest < ApplicationSystemTestCase
  setup do
    @day = days(:one)
  end

  test "visiting the index" do
    visit days_url
    assert_selector "h1", text: "Days"
  end

  test "creating a Day" do
    visit days_url
    click_on "New Day"

    fill_in "Date", with: @day.date
    fill_in "Description", with: @day.description
    check "Is locked" if @day.is_locked
    click_on "Create Day"

    assert_text "Day was successfully created"
    assert_selector "h1", text: "Days"
  end

  test "updating a Day" do
    visit day_url(@day)
    click_on "Edit", match: :first

    fill_in "Date", with: @day.date
    fill_in "Description", with: @day.description
    check "Is locked" if @day.is_locked
    click_on "Update Day"

    assert_text "Day was successfully updated"
    assert_selector "h1", text: "Days"
  end

  test "destroying a Day" do
    visit edit_day_url(@day)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Day was successfully destroyed"
  end
end
