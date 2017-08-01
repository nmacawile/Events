require 'test_helper'

class InvitesControllerTest < ActionDispatch::IntegrationTest
  test "redirect new when no one is signed in" do
    get new_event_invite_path(events(:birthday))
    assert_redirected_to signin_path
  end
end
