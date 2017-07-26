require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @host = User.create(name: "Foobar",
                        email: "foobar@foo.bar",
                        password: "password")
                       
    @event = Event.new(title: "Foobar's Birthday",
                       description: "Descriptions\nDescriptions",
                       venue: "Foobar's place",
                       time_start: 2.days.from_now,
                       time_end: 50.hours.from_now,
                       host: @host)
  end
  
  def valid?
    @event.valid?
  end
  
  test "should be valid" do
    assert @event.valid?
    assert User.exists?(@host.id)
  end
  
  test "host should be present" do
    @event.host = nil
    assert_not valid?
  end
  
  test "title should not be blank" do
    @event.title = "     "
    assert_not valid?
  end
  
  test "title should not be too long" do
    @event.title = "a" * 51
    assert_not valid?
  end
  
  test "description should be optional" do
    @event.description = ""
    assert valid?
    @event.description = nil
    assert valid?
  end
  
  test "description should not be too long" do
    @event.description = "a" * 1001
    assert_not valid?
  end
  
  test "venue should be present" do
    @event.venue = "   "
    assert_not valid?
  end
  
  test "venue string should not be too long" do
    @event.venue = "a" * 51
    assert_not valid?
  end
  
  test "time_start should be present"  do
    @event.time_start = " "
    assert_not valid?
  end
  
  test "time_end should be present"  do
    @event.time_end = " "
    assert_not valid?
  end
  
  test "start time should be a valid datetime object" do
    @event.time_start = "invalid"
    assert_not valid?
  end
  
  test "end time should be a valid datetime object" do
    @event.time_end = "invalid"
    assert_not valid?
  end
  
  test "should take place in the future should still be ongoing" do
    @event.time_start = 2.hours.ago
    @event.time_end = 1.hour.ago
    assert_not valid?
  end
  
  test "time_end should be after time_start" do
    @event.time_start = 4.hours.from_now
    @event.time_end = 3.hours.from_now
    assert_not valid?
  end
end
