require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  include Factories

  test "should get next" do
    create_exercise
    get join_exercises_url
    assert_response :success
    assert_match "1 person is using Livelonger right now", response.body
  end
end
