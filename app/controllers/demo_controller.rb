class DemoController < ApplicationController
  def index
    @exercise = NextExercise.demo
  end
end
