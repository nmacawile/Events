require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "get signin_path" do
    get signin_path
    assert_response :success
  end
end
