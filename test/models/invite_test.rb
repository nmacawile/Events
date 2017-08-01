require 'test_helper'

class InviteTest < ActiveSupport::TestCase
  def setup
    @invite = Invite.new(inviter: users(:host), invitee: users(:guest), event: events(:birthday))
  end
  
  test "should be valid" do
    assert @invite.valid?
  end
  
  test "should delete invites associated with deleted event" do
    assert_difference "Invite.where(event: events(:baseball_game)).count", -1 do
      events(:baseball_game).destroy
    end
  end
  
  test "should delete invites associated with deleted inviter" do
    assert_difference "Invite.where(inviter: users(:baseball_inviter)).count", -1 do
      users(:baseball_inviter).destroy
    end
  end
  
  test "should delete invites associated with deleted invitee" do
    assert_difference "Invite.where(invitee: users(:baseball_invitee)).count", -1 do
      users(:baseball_invitee).destroy
    end
  end
end
