require 'test_helper'

class EtsySetupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @etsy_setup = etsy_setups(:one)
  end

  test "should get index" do
    get etsy_setups_url
    assert_response :success
  end

  test "should get new" do
    get new_etsy_setup_url
    assert_response :success
  end

  test "should create etsy_setup" do
    assert_difference('EtsySetup.count') do
      post etsy_setups_url, params: { etsy_setup: { api_key: @etsy_setup.api_key, api_secret: @etsy_setup.api_secret, code: @etsy_setup.code, secret: @etsy_setup.secret, token: @etsy_setup.token } }
    end

    assert_redirected_to etsy_setup_url(EtsySetup.last)
  end

  test "should show etsy_setup" do
    get etsy_setup_url(@etsy_setup)
    assert_response :success
  end

  test "should get edit" do
    get edit_etsy_setup_url(@etsy_setup)
    assert_response :success
  end

  test "should update etsy_setup" do
    patch etsy_setup_url(@etsy_setup), params: { etsy_setup: { api_key: @etsy_setup.api_key, api_secret: @etsy_setup.api_secret, code: @etsy_setup.code, secret: @etsy_setup.secret, token: @etsy_setup.token } }
    assert_redirected_to etsy_setup_url(@etsy_setup)
  end

  test "should destroy etsy_setup" do
    assert_difference('EtsySetup.count', -1) do
      delete etsy_setup_url(@etsy_setup)
    end

    assert_redirected_to etsy_setups_url
  end
end
