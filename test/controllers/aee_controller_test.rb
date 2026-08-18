require "test_helper"

class AeeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get aee_index_url
    assert_response :success
  end
end
