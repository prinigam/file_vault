require "test_helper"

class SharedUploadsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get shared_uploads_show_url
    assert_response :success
  end
end
