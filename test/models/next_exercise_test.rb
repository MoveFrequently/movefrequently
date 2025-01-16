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
    not_active_yet = create_exercise(name: "Not active yet", active_at: 1.hour.from_now)
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

  test "record returns upcoming exercise" do
    exercise = create_exercise
    upcoming = NextExercise.create!(
      exercise: exercise,
      next_at: 30.minutes.from_now
    )

    assert_equal upcoming, NextExercise.record
  end

  test "record creates new exercise if none upcoming" do
    exercise = create_exercise
    old = NextExercise.create!(
      exercise: exercise,
      next_at: 1.hour.ago
    )

    next_exercise = NextExercise.record

    assert_not_equal old, next_exercise
    assert_in_delta Time.now.utc + NextExercise::PERIOD, next_exercise.next_at, 1.second
  end

  test "record returns earliest upcoming exercise" do
    exercise = create_exercise
    earlier = NextExercise.create!(
      exercise: exercise,
      next_at: 15.minutes.from_now
    )
    later = NextExercise.create!(
      exercise: exercise,
      next_at: 45.minutes.from_now
    )

    assert_equal earlier, NextExercise.record
  end

  test "join! increments joined_by_count" do
    exercise = create_exercise
    next_exercise = NextExercise.create!(exercise: exercise, next_at: 30.minutes.from_now)

    next_exercise.join!(nil)
    assert_equal 1, next_exercise.joined_by_count
  end
end
