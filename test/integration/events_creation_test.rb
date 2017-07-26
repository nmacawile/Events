require 'test_helper'

class EventsCreationTest < ActionDispatch::IntegrationTest
  test "should create event if all information are valid" do
    sign_in_as users(:one)
    get new_event_path
    assert_difference "users(:one).hosted_events.count", 1 do
      post events_path, params: { event: { title: "Title4321",
                                  description: "Description",
                                  venue: "House",
                                  time_start: 2.days.from_now,
                                  time_end: 3.days.from_now
                                  } }
    end
    follow_redirect!
    assert_template "events/show"
  end
  
  test "should not create event if some info are invalid" do
    sign_in_as users(:one)
    get new_event_path
    assert_no_difference "users(:one).hosted_events.count" do
      post events_path, params: { event: { title: "",
                                  description: "Description",
                                  venue: "House",
                                  time_start: 2.days.from_now,
                                  time_end: 3.days.from_now
                                  } }
    end
    assert_template "events/new"
  end
  
  test "ignore host_id attribute and create event according to the signed in user" do
    sign_in_as users(:one)
    get new_event_path
    assert_difference "users(:one).hosted_events.count", 1 do
      post events_path, params: { event: { title: "Title",
                                  description: "Description",
                                  venue: "House",
                                  host_id: 421321,
                                  time_start: 2.days.from_now,
                                  time_end: 3.days.from_now
                                  } }
    end
  end
end
