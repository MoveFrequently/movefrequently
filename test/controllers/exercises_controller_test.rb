require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  test "should get sync" do
    get exercises_sync_url
    assert_response :success
  end

  test "should get next" do
    get exercises_next_url
    assert_response :success
  end
end
