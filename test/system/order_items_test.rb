require "application_system_test_case"

class OrderItemsTest < ApplicationSystemTestCase
  setup do
    @order_item = order_items(:one)
  end

  test "visiting the index" do
    visit order_items_url
    assert_selector "h1", text: "Order Items"
  end

  test "creating a Order item" do
    visit order_items_url
    click_on "New Order Item"

    fill_in "Order", with: @order_item.order_id
    fill_in "Price", with: @order_item.price
    fill_in "Product", with: @order_item.product_id
    fill_in "Quantity", with: @order_item.quantity
    click_on "Create Order item"

    assert_text "Order item was successfully created"
    assert_selector "h1", text: "Order Items"
  end

  test "updating a Order item" do
    visit order_item_url(@order_item)
    click_on "Edit", match: :first

    fill_in "Order", with: @order_item.order_id
    fill_in "Price", with: @order_item.price
    fill_in "Product", with: @order_item.product_id
    fill_in "Quantity", with: @order_item.quantity
    click_on "Update Order item"

    assert_text "Order item was successfully updated"
    assert_selector "h1", text: "Order Items"
  end

  test "destroying a Order item" do
    visit edit_order_item_url(@order_item)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Order item was successfully destroyed"
  end
end
