require "application_system_test_case"

class EtsySetupsTest < ApplicationSystemTestCase
  setup do
    @etsy_setup = etsy_setups(:one)
  end

  test "visiting the index" do
    visit etsy_setups_url
    assert_selector "h1", text: "Etsy Setups"
  end

  test "creating a Etsy setup" do
    visit etsy_setups_url
    click_on "New Etsy Setup"

    fill_in "Api key", with: @etsy_setup.api_key
    fill_in "Api secret", with: @etsy_setup.api_secret
    fill_in "Code", with: @etsy_setup.code
    fill_in "Secret", with: @etsy_setup.secret
    fill_in "Token", with: @etsy_setup.token
    click_on "Create Etsy setup"

    assert_text "Etsy setup was successfully created"
    click_on "Back"
  end

  test "updating a Etsy setup" do
    visit etsy_setups_url
    click_on "Edit", match: :first

    fill_in "Api key", with: @etsy_setup.api_key
    fill_in "Api secret", with: @etsy_setup.api_secret
    fill_in "Code", with: @etsy_setup.code
    fill_in "Secret", with: @etsy_setup.secret
    fill_in "Token", with: @etsy_setup.token
    click_on "Update Etsy setup"

    assert_text "Etsy setup was successfully updated"
    click_on "Back"
  end

  test "destroying a Etsy setup" do
    visit etsy_setups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Etsy setup was successfully destroyed"
  end
end
