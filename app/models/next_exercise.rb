class NextExercise < ApplicationRecord
  delegate :name, :steps, :description, to: :exercise, allow_nil: true

  belongs_to :exercise

  PERIOD = Rails.env.development? ? 20.seconds : 50.minutes
  DEMO_PERIOD = 3.seconds

  def self.demo
    new(id: 1, next_at: Time.now.utc + DEMO_PERIOD, exercise: Exercise.first)
  end

  def self.record
    record = self.order(next_at: :asc).where("next_at > ?", Time.now.utc).includes(:exercise).first || self.create_next
  end

  def join!(latest_joined)
    if latest_joined.nil? || latest_joined < self.id
      self.class.connection.execute(<<-SQL)
        UPDATE next_exercises
        SET joined_by_count = COALESCE(joined_by_count, 0) + 1
        WHERE id = #{id};
      SQL
      self.joined_by_count += 1

      broadcast_replace_to(
        self,
        target: "joined-by-count",
        partial: "exercises/joined_by_count",
        locals: { exercise: self }
      )
    end
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
