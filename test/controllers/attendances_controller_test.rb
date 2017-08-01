require 'test_helper'

class AttendancesControllerTest < ActionDispatch::IntegrationTest
  test "redirect create when not signed in" do
    assert_no_difference "Attendance.count" do
      post attendances_path, params: { attendance: { event_attended_id: events(:exclusive).id  } }
    end
    assert_redirected_to signin_path
  end
end
