class AdminController < ApplicationController
  layout "admin"
  before_action :require_admin!

  def require_admin!
    return if Rails.env.test?
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.dig(:admin_auth, :username) && password == Rails.application.credentials.dig(:admin_auth, :password)
    end
  end
end
