require 'test_helper'

class EventsCreationTest < ActionDispatch::IntegrationTest
  def setup
    @params_hash = { params: { event: { title: "Title4321",
                               description: "Description",
                               venue: "House",
                               time_start: 2.days.from_now,
                               time_end: 3.days.from_now } } }
    @user = users(:one)
  end
  
  test "should create event if all information are valid" do
    sign_in_as @user
    get new_event_path
    assert_difference "@user.events_hosted.count", 1 do
      post events_path, @params_hash
    end
    follow_redirect!
    assert_template "events/show"
  end
  
  test "should not create event if some info are invalid" do
    sign_in_as @user
    get new_event_path
    @params_hash[:params][:event][:title] = ""
    assert_no_difference "@user.events_hosted.count" do
      post events_path, @params_hash
    end
    assert_template "events/new"
  end
  
  test "ignore host_id attribute and create event according to the signed in user" do
    sign_in_as @user
    get new_event_path
    @params_hash[:params][:event][:host_id] = 421321
    assert_difference "@user.events_hosted.count", 1 do
      post events_path, @params_hash
    end
  end
end
