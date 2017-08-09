class EventsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy]
  
  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees
    @invites = @event.invites.group_by(&:invitee)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.host = current_user
    if @event.save
      Attendance.create(attendee: current_user, event_attended: @event)
      redirect_to event_path(@event)
    else
      render "new"
    end
  end

  def index
    @unfinished = Event.unfinished
    @finished = Event.finished
  end
  
  private
  
    def event_params
      params.require(:event).permit(:title, :description, :time_start, :time_end, :venue)
    end
    
    def signed_in_user
      redirect_to signin_path unless signed_in?
    end
end
