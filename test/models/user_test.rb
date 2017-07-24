require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Foo Bar",
                     email: "foo@bar.baz",
                     password: "password",
                     password_confirmation: "password")
  end
  
  def valid?
    @user.valid?
  end
  
  test "must be valid" do
    assert valid?
  end
  
  test "name should not be blank" do
    @user.name = "       "
    assert_not valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not valid?
  end
  
  test "email should not be blank" do
    @user.email = "       "
    assert_not valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 251
    assert_not valid?
  end
  
  test "user validation should reject invalid email format" do
    invalid_emails = %w[ foo
                         foo@
                         foo@bar
                         foo@bar..baz
                         @bar.baz
                         bar.baz
                         foo..bar@bar.baz
                         $foo@bar.baz ]
    invalid_emails.each do |email|
      @user.email = email
      assert_not valid?
    end
  end
  
  test "user validation should accept valid email format" do
    valid_emails = %w[ foo@bar.baz 
                       foo.bar@bar.baz
                       foo-bar@bar.baz
                       foo_bar@bar.baz
                       foo+bar@bar.baz
                       foo@bar.ba.az
                       foo@bar-bar.baz
                       ____@bar.baz
                       foo123@bar.baz
                       123@bar.baz ]
                       
    valid_emails.each do |email|
      @user.email = email
      assert valid?
    end
  end
  
  test "email should be unique" do
    copy = @user.dup
    copy.email.upcase!
    copy.save
    assert_not valid?
  end
  
  test "email should be saved in lower-case" do
    upper_case = @user.email.upcase!
    @user.save
    @user.reload
    assert_equal @user.email, upper_case.downcase
  end
  
  test "password should not be blank" do
    @user.password = @user.password_confirmation = "        "
    assert_not valid?
  end
  
  test "password should not be too short" do
    @user.password = @user.password_confirmation = "abcde"
    assert_not valid?
  end
end
