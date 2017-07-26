class EventsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy]
  
  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.host = current_user
    if @event.save
      redirect_to event_path(@event)
    else
      render "new"
    end
  end

  def index
    @events = Event.all
  end
  
  private
  
    def event_params
      params.require(:event).permit(:title, :description, :time_start, :time_end, :venue)
    end
    
    def signed_in_user
      redirect_to signin_path unless signed_in?
    end
end
