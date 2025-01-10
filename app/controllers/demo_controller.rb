class DemoController < ApplicationController
  def index
    session[:demo_seen] = true
    @exercise = NextExercise.demo
  end
end
