require "test_helper"

class DayProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @day_product = day_products(:one)
  end

  test "should get index" do
    get day_products_url
    assert_response :success
  end

  test "should get new" do
    get new_day_product_url
    assert_response :success
  end

  test "should create day_product" do
    assert_difference("DayProduct.count") do
      post day_products_url, params: {day_product: {day_id: @day_product.day_id, product_id: @day_product.product_id}}
    end

    assert_redirected_to day_product_url(DayProduct.last)
  end

  test "should show day_product" do
    get day_product_url(@day_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_day_product_url(@day_product)
    assert_response :success
  end

  test "should update day_product" do
    patch day_product_url(@day_product), params: {day_product: {day_id: @day_product.day_id, product_id: @day_product.product_id}}
    assert_redirected_to day_product_url(@day_product)
  end

  test "should destroy day_product" do
    assert_difference("DayProduct.count", -1) do
      delete day_product_url(@day_product)
    end

    assert_redirected_to day_products_url
  end
end
