require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  include Factories

  test "should get next" do
    create_exercise
    get next_exercises_url
    assert_response :success
    assert_match "Joined by 1 people", response.body
  end
end
