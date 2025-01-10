class ExercisesController < ApplicationController
  def show
  end

  def next
    @exercise = Exercise.next
  end
end
