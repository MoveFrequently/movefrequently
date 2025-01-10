require "test_helper"

class DemoControllerTest < ActionDispatch::IntegrationTest
  include Factories

  test "should get index" do
    create_exercise
    get demo_url
    assert_response :success
    assert_match "demo", response.body
  end
end
