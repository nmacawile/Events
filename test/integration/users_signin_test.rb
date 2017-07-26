require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end
  
  test "signin with valid account details followed by a signout" do
    get signin_path
    post signin_path, params: { session: { email: @user.email,
                                           password: "password" } }
    assert is_signed_in?
    delete signout_path
    assert_not is_signed_in?
    assert_redirected_to root_url
  end
  
  test "signin with invalid account details" do
    get signin_path
    post signin_path, params: { session: { email: "", password: "" } }
    assert_template "sessions/new"
    assert_not is_signed_in?
  end
end
