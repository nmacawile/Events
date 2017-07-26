require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  #test "should get show" do
  #  get events_show_url
  #  assert_response :success
  #end
  
  test "should get index" do
    get root_url
    assert_template "events/index"
    assert_response :success
  end

  test "should get new when signed in" do
    sign_in_as users(:one)
    get new_event_path
    assert_response :success
  end
  
  test "should redirect new when not signed in" do
    get new_event_path
    assert_redirected_to signin_path
  end
  
  test "should redirect create when not signed in" do
    post events_path, params: { event: { title: "Title123",
                                description: "Description",
                                venue: "House",
                                time_start: 2.days.from_now,
                                time_end: 3.days.from_now } }
    assert_redirected_to signin_path
  end
end
