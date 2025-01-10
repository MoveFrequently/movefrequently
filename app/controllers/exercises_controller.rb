class ExercisesController < ApplicationController
  before_action :redirect_to_demo, if: :first_time?

  def next
    @exercise = Exercise.next

    @exercise.join!(latest_joined)
    update_latest_joined(@exercise.id)
    @exercise
  end

  private

    def redirect_to_demo
      redirect_to demo_path
    end

    def first_time?
      session[:demo_seen].nil?
    end

    def update_latest_joined(id)
      session[:latest_joined] = [ id, session[:latest_joined] ].compact.max
    end

    def latest_joined
      session[:latest_joined]
    end
end
