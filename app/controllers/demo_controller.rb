class DemoController < ApplicationController
  def index
    session[:demo_seen] = true
  end

  def test
    @exercise = NextExercise.demo
  end
end
