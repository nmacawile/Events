ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def is_signed_in?
    !!session[:user_id]
  end
end

class ActionDispatch::IntegrationTest
  def sign_in_as(user)
    post signin_path, params: { session: { email: user.email,
                                           password: "password" } }
  end
end