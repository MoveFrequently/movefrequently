require "test_helper"

class Admin::FeaturesControllerTest < ActionDispatch::IntegrationTest
  fixtures "admin/features"

  setup do
    @admin_feature = admin_features(:one)
  end

  test "should get index" do
    get admin_features_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_feature_url
    assert_response :success
  end

  test "should create admin_feature" do
    assert_difference("Admin::Feature.count") do
      post admin_features_url, params: { admin_feature: { feature: @admin_feature.feature, title: @admin_feature.title } }
    end

    assert_redirected_to admin_feature_url(Admin::Feature.last)
  end

  test "should show admin_feature" do
    get admin_feature_url(@admin_feature)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_feature_url(@admin_feature)
    assert_response :success
  end

  test "should update admin_feature" do
    patch admin_feature_url(@admin_feature), params: { admin_feature: { feature: @admin_feature.feature, title: @admin_feature.title } }
    assert_redirected_to admin_feature_url(@admin_feature)
  end

  test "should destroy admin_feature" do
    assert_difference("Admin::Feature.count", -1) do
      delete admin_feature_url(@admin_feature)
    end

    assert_redirected_to admin_features_url
  end
end
