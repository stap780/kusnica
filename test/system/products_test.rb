require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "creating a Product" do
    visit products_url
    click_on "New Product"

    fill_in "Cat", with: @product.cat
    fill_in "Desc", with: @product.desc
    fill_in "Ebay", with: @product.ebay_id
    fill_in "Etsy", with: @product.etsy_id
    fill_in "Image", with: @product.image
    fill_in "Ins", with: @product.ins_id
    fill_in "Ins var", with: @product.ins_var_id
    fill_in "Oldprice", with: @product.oldprice
    fill_in "Parametr", with: @product.parametr
    fill_in "Price", with: @product.price
    fill_in "Quantity", with: @product.quantity
    fill_in "Sku", with: @product.sku
    fill_in "Title", with: @product.title
    fill_in "Url", with: @product.url
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "updating a Product" do
    visit products_url
    click_on "Edit", match: :first

    fill_in "Cat", with: @product.cat
    fill_in "Desc", with: @product.desc
    fill_in "Ebay", with: @product.ebay_id
    fill_in "Etsy", with: @product.etsy_id
    fill_in "Image", with: @product.image
    fill_in "Ins", with: @product.ins_id
    fill_in "Ins var", with: @product.ins_var_id
    fill_in "Oldprice", with: @product.oldprice
    fill_in "Parametr", with: @product.parametr
    fill_in "Price", with: @product.price
    fill_in "Quantity", with: @product.quantity
    fill_in "Sku", with: @product.sku
    fill_in "Title", with: @product.title
    fill_in "Url", with: @product.url
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "destroying a Product" do
    visit products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product was successfully destroyed"
  end
end
