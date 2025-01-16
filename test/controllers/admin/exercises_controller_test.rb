require "test_helper"

class Admin::ExercisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    exercise = create_exercise(name: "First Exercise")
    @admin_exercise = Admin::Exercise.last
  end

  test "should get index" do
    get admin_exercises_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_exercise_url
    assert_response :success
  end

  test "should create admin_exercise" do
    assert_difference("Admin::Exercise.count") do
      post admin_exercises_url, params: { admin_exercise: { name: "New Exercise", description: "New Exercise Description", steps: [ "Step 1", "Step 2", "Step 3" ] } }
    end

    assert_redirected_to admin_exercise_url(Admin::Exercise.last)
  end

  test "should show admin_exercise" do
    get admin_exercise_url(@admin_exercise)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_exercise_url(@admin_exercise)
    assert_response :success
  end

  test "should update admin_exercise" do
    patch admin_exercise_url(@admin_exercise), params: { admin_exercise: {} }
    assert_redirected_to admin_exercise_url(@admin_exercise)
  end

  test "should destroy admin_exercise" do
    assert_difference("Admin::Exercise.count", -1) do
      delete admin_exercise_url(@admin_exercise)
    end

    assert_redirected_to admin_exercises_url
  end
end
