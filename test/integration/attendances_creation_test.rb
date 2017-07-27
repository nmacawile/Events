require 'test_helper'

class AttendancesCreationTest < ActionDispatch::IntegrationTest
  def setup
    @event_hash = { params: { event: { title: "Title4321",
                               description: "Description",
                               venue: "House",
                               time_start: 2.days.from_now,
                               time_end: 3.days.from_now } } }
    @user = users(:one)
  end
  
  test "should automatically create attendance for the host upon the event creation" do
    sign_in_as @user
    get new_event_path
    assert_difference "@user.events_attended.count", 1 do
      post events_path, @event_hash
    end
    latest_entry = Attendance.last
    assert_equal latest_entry.event_attended.title, @event_hash[:params][:event][:title]
    assert_equal latest_entry.attendee.name, @user.name
    follow_redirect!
    assert_template "events/show"
  end
end
