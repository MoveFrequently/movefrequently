require "application_system_test_case"

class Admin::FeaturesTest < ApplicationSystemTestCase
  setup do
    @admin_feature = admin_features(:one)
  end

  test "visiting the index" do
    visit admin_features_url
    assert_selector "h1", text: "Features"
  end

  test "should create feature" do
    visit admin_features_url
    click_on "New feature"

    fill_in "Feature", with: @admin_feature.feature
    fill_in "Title", with: @admin_feature.title
    click_on "Create Feature"

    assert_text "Feature was successfully created"
    click_on "Back"
  end

  test "should update Feature" do
    visit admin_feature_url(@admin_feature)
    click_on "Edit this feature", match: :first

    fill_in "Feature", with: @admin_feature.feature
    fill_in "Title", with: @admin_feature.title
    click_on "Update Feature"

    assert_text "Feature was successfully updated"
    click_on "Back"
  end

  test "should destroy Feature" do
    visit admin_feature_url(@admin_feature)
    click_on "Destroy this feature", match: :first

    assert_text "Feature was successfully destroyed"
  end
end
