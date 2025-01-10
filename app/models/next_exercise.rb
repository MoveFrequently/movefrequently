class NextExercise < ApplicationRecord
  delegate :name, :steps, :description, to: :exercise, allow_nil: true

  belongs_to :exercise

  PERIOD = Rails.env.development? ? 10.seconds : 45.minutes

  def self.demo
    new(id: 1, next_at: Time.now.utc + 10.seconds, exercise: Exercise.first)
  end

  def self.record
    self.order(next_at: :asc).where("next_at > ?", Time.now.utc).includes(:exercise).first || self.create_next
  end

  def self.create_next
    latest = last

    next_at = if latest.nil?
       Time.now.utc + PERIOD
    elsif latest.next_at < Time.now.utc - PERIOD
      Time.now.utc + PERIOD
    else
      latest.next_at + PERIOD
    end

    exercise_id = if latest.nil?
      Exercise.select(:id).first.id
    else
      latest_id = latest.exercise_id
      next_exercise = Exercise.where("id > ?", latest_id).select(:id).first

      if next_exercise.nil?
        Exercise.select(:id).first.id
      else
        next_exercise.id
      end
    end

    create!(next_at: next_at, exercise_id: exercise_id)
  end
end
