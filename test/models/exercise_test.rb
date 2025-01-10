require "test_helper"

class ExerciseTest < ActiveSupport::TestCase
  test "generate exercise" do
    now = Time.now
    times = 2
    VCR.use_cassette("generate_exercise") do
      times.times do
        Exercise.generate_and_save!
      end
    end

    all = Exercise.where("created_at > ?", now)
    assert_equal times, all.count
    assert_equal times, all.pluck(:name).uniq.count
    assert_equal times, all.pluck(:description).uniq.count
    assert all.pluck(:steps).all? { |steps| steps.is_a?(Array) && steps.length > 3 }
  end
end
