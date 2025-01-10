class ExercisesController < ApplicationController
  def next
    @exercise = Exercise.next

    @exercise.join!(latest_joined)
    update_latest_joined(@exercise.id)
    @exercise
  end

  private

    def update_latest_joined(id)
      session[:latest_joined] = [ id, session[:latest_joined] ].compact.max
    end

    def latest_joined
      session[:latest_joined]
    end
end
