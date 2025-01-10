require "test_helper"

class NextExerciseTest < ActiveSupport::TestCase
  test "create_next creates first exercise when no exercises exist" do
    exercise = create_exercise(name: "First Exercise")
    next_exercise = NextExercise.create_next

    assert_equal exercise.id, next_exercise.exercise_id
    assert_in_delta Time.now.utc + NextExercise::PERIOD, next_exercise.next_at, 1.second
  end

  test "create_next uses next exercise in sequence" do
    first = create_exercise(name: "First")
    second = create_exercise(name: "Second")

    next_exercise = NextExercise.create!(exercise: first, next_at: 1.hour.ago)
    new_next = NextExercise.create_next

    assert_equal second.id, new_next.exercise_id
    assert_in_delta Time.now.utc + NextExercise::PERIOD, new_next.next_at, 1.second
  end

  test "create_next wraps back to first exercise after last" do
    first = create_exercise(name: "First")
    last = create_exercise(name: "Last")

    next_exercise = NextExercise.create!(exercise: last, next_at: 1.hour.ago)
    new_next = NextExercise.create_next

    assert_equal first.id, new_next.exercise_id
    assert_in_delta Time.now.utc + NextExercise::PERIOD, new_next.next_at, 1.second
  end

  test "create_next sets next_at relative to previous exercise if recent" do
    exercise = create_exercise(name: "Exercise")
    previous = NextExercise.create!(
      exercise: exercise,
      next_at: 30.minutes.from_now
    )

    new_next = NextExercise.create_next

    assert_equal previous.next_at + NextExercise::PERIOD, new_next.next_at
  end

  test "create_next resets timing if previous exercise is old" do
    exercise = create_exercise(name: "Exercise")
    previous = NextExercise.create!(
      exercise: exercise,
      next_at: 2.hours.ago
    )

    new_next = NextExercise.create_next

    assert_in_delta Time.now.utc + NextExercise::PERIOD, new_next.next_at, 1.second
  end
end
