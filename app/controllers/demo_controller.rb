class DemoController < ApplicationController
  override_frame_layout

  def index
    session[:demo_seen] = true
  end

  def test
    @exercise = NextExercise.demo
  end
end
