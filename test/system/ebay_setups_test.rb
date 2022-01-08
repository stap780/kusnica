require "application_system_test_case"

class EbaySetupsTest < ApplicationSystemTestCase
  setup do
    @ebay_setup = ebay_setups(:one)
  end

  test "visiting the index" do
    visit ebay_setups_url
    assert_selector "h1", text: "Ebay Setups"
  end

  test "creating a Ebay setup" do
    visit ebay_setups_url
    click_on "New Ebay Setup"

    fill_in "Ebay password", with: @ebay_setup.ebay_password
    fill_in "Ebay username", with: @ebay_setup.ebay_username
    click_on "Create Ebay setup"

    assert_text "Ebay setup was successfully created"
    click_on "Back"
  end

  test "updating a Ebay setup" do
    visit ebay_setups_url
    click_on "Edit", match: :first

    fill_in "Ebay password", with: @ebay_setup.ebay_password
    fill_in "Ebay username", with: @ebay_setup.ebay_username
    click_on "Update Ebay setup"

    assert_text "Ebay setup was successfully updated"
    click_on "Back"
  end

  test "destroying a Ebay setup" do
    visit ebay_setups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ebay setup was successfully destroyed"
  end
end
