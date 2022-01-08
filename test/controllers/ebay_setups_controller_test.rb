require 'test_helper'

class EbaySetupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ebay_setup = ebay_setups(:one)
  end

  test "should get index" do
    get ebay_setups_url
    assert_response :success
  end

  test "should get new" do
    get new_ebay_setup_url
    assert_response :success
  end

  test "should create ebay_setup" do
    assert_difference('EbaySetup.count') do
      post ebay_setups_url, params: { ebay_setup: { ebay_password: @ebay_setup.ebay_password, ebay_username: @ebay_setup.ebay_username } }
    end

    assert_redirected_to ebay_setup_url(EbaySetup.last)
  end

  test "should show ebay_setup" do
    get ebay_setup_url(@ebay_setup)
    assert_response :success
  end

  test "should get edit" do
    get edit_ebay_setup_url(@ebay_setup)
    assert_response :success
  end

  test "should update ebay_setup" do
    patch ebay_setup_url(@ebay_setup), params: { ebay_setup: { ebay_password: @ebay_setup.ebay_password, ebay_username: @ebay_setup.ebay_username } }
    assert_redirected_to ebay_setup_url(@ebay_setup)
  end

  test "should destroy ebay_setup" do
    assert_difference('EbaySetup.count', -1) do
      delete ebay_setup_url(@ebay_setup)
    end

    assert_redirected_to ebay_setups_url
  end
end
