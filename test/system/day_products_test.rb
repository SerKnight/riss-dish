require "application_system_test_case"

class DayProductsTest < ApplicationSystemTestCase
  setup do
    @day_product = day_products(:one)
  end

  test "visiting the index" do
    visit day_products_url
    assert_selector "h1", text: "Day Products"
  end

  test "creating a Day product" do
    visit day_products_url
    click_on "New Day Product"

    fill_in "Day", with: @day_product.day_id
    fill_in "Product", with: @day_product.product_id
    click_on "Create Day product"

    assert_text "Day product was successfully created"
    assert_selector "h1", text: "Day Products"
  end

  test "updating a Day product" do
    visit day_product_url(@day_product)
    click_on "Edit", match: :first

    fill_in "Day", with: @day_product.day_id
    fill_in "Product", with: @day_product.product_id
    click_on "Update Day product"

    assert_text "Day product was successfully updated"
    assert_selector "h1", text: "Day Products"
  end

  test "destroying a Day product" do
    visit edit_day_product_url(@day_product)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Day product was successfully destroyed"
  end
end
