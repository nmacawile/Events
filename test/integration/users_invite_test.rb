require 'test_helper'

class UserInviteTest < ActionDispatch::IntegrationTest
  def setup
    @birthday = events(:birthday)
    @inviter = users(:guest)
    @invitee = users(:other_guest)
  end 
  
  test "valid invite conditions" do
    sign_in_as @inviter
    get new_event_invite_path @birthday
    assert_difference "Invite.count", 1 do
      post event_invites_path(@birthday), params: { invite: { invitee_id: @invitee.id } }
    end
    assert_redirected_to event_path(@birthday)
  end
 
  test "invalid invitee id" do
    sign_in_as @inviter
    get new_event_invite_path @birthday
    assert_no_difference "Invite.count" do
      post event_invites_path(@birthday), params: { invite: { invitee_id: "invalid" } }
    end
    follow_redirect!
    assert_template "invites/new"
  end
 
  test "should fail if inviter is not attending the event" do
    sign_in_as @inviter
    get new_event_invite_path events(:exclusive)
    assert_no_difference "Invite.count" do
      post event_invites_path(events(:exclusive)), params: { invite: { invitee_id: @invitee.id } }
    end
    assert_redirected_to event_path(events(:exclusive))
  end
  
  test "should fail if invitee is already attending the event" do
    sign_in_as @inviter
    get new_event_invite_path @birthday
    assert_difference "Invite.count", 1 do
      post event_invites_path(@birthday), params: { invite: { invitee_id: @invitee.id } }
    end
    assert_redirected_to event_path(@birthday)
    
    delete signout_path
    
    sign_in_as @invitee
    post attendances_path, params: { attendance: { event_attended_id: @birthday.id } }
    
    delete signout_path
    
    sign_in_as @inviter
    get new_event_invite_path @birthday
    assert_no_difference "Invite.count" do
      post event_invites_path(@birthday), params: { invite: { invitee_id: @invitee.id } }
    end
  end
end
