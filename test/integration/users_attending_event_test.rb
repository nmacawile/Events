require 'test_helper'

class UsersAttendingEventTest < ActionDispatch::IntegrationTest
  def setup
    @invited = users(:other_guest)
    @uninvited = users(:guest)
    @event = events(:exclusive)
    @invite = invites(:secret_event_invite)
  end
  
  test "create attendance if user has invitation to event" do
    sign_in_as @invited
    assert_difference "Attendance.count", 1 do
      post attendances_path, params: { attendance: { event_attended_id: @event.id  } }
    end
    assert_not Invite.exists?(@invite.id)
    assert_redirected_to event_path(@event)
  end
  
  test "redirects to event if user already has an attendace" do
    sign_in_as @invited
    assert_difference "Attendance.count", 1 do
      post attendances_path, params: { attendance: { event_attended_id: @event.id  } }
    end
    assert_redirected_to event_path(@event)
    assert_no_difference "Attendance.count" do
      post attendances_path, params: { attendance: { event_attended_id: @event.id  } }
    end
    assert_redirected_to event_path(@event)
  end
  
  test "redirects to event if user has no invitation to event" do
    sign_in_as @uninvited
    assert_no_difference "Attendance.count" do
      post attendances_path, params: { attendance: { event_attended_id: @event.id  } }
    end
    assert_redirected_to event_path(@event)
  end
end
