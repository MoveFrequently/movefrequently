require "test_helper"

class DemoControllerTest < ActionDispatch::IntegrationTest
  include Factories

  test "should get index" do
    create_exercise
    get why_url
    assert_response :success
    assert_match "We need to move frequently.", response.body
  end
end
