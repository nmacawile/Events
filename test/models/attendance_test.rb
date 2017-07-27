require 'test_helper'

class AttendanceTest < ActiveSupport::TestCase
  test "should delete attendances associated with a deleted event" do
    assert_difference "Attendance.where(event_attended: events(:birthday)).count", -2 do
      events(:birthday).destroy
    end
  end
  
  test "should delete attendances associated with a deleted attendee" do
    assert_difference "Attendance.where(attendee: users(:guest)).count", -2 do
      users(:guest).destroy
    end
  end
end
