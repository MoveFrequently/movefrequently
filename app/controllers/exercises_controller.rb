class ExercisesController < ApplicationController
  override_frame_layout

  def index
    @exercise = Exercise.next
  end

  def join
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
