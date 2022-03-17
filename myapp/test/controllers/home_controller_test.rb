require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get layouts" do
    get home_layouts_url
    assert_response :success
  end
end
