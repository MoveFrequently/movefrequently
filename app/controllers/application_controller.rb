class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  def self.override_frame_layout(_layout: "body_frame")
    layout -> { _layout if turbo_frame_request? }
  end
end
