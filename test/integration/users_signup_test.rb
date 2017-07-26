require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "should create user if all given attributes are valid" do
    assert_difference "User.count", 1 do
      get signup_path
      post signup_path, params: { user: { name: "Valid User01",
                                          email: "validuser01@email.com",
                                          password: "password",
                                          password_confirmation: "password" } }
      assert_redirected_to user_path(User.find_by(email: "validuser01@email.com"))
    end
  end
  
  test "should not create user if some attributes are invalid" do
    assert_no_difference "User.count" do
      get signup_path
      post signup_path, params: { user: { name: "",
                                          email: "",
                                          password: "password",
                                          password_confirmation: "password" } }
      assert_template "users/new"
    end
  end
end
