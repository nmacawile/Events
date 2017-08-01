class AttendancesController < ApplicationController
  before_action :user_signed_in, only: :create
  before_action :invited, only: :create
  before_action :prevent_duplication, only: :create
  
  def create
    event_id = params[:attendance][:event_attended_id]
    attendance = Attendance.new(attendance_params)
    attendance.attendee_id = current_user.id
    if attendance.save
      Invite.where(event_id: event_id, invitee_id: current_user.id).destroy_all
      redirect_to event_path(event_id)
    else
      redirect_to current_user
    end
  end
  
  private
  
    def attendance_params
      params.require(:attendance).permit(:event_attended_id)
    end
    
    def invited
      event_id = params[:attendance][:event_attended_id]
      redirect_to event_path(event_id) unless invited_to?(event_id)
    end
    
    def prevent_duplication
      event_id = params[:attendance][:event_attended_id]
      redirect_to event_path(event_id) if already_attending?(event_id)
    end
    
    def user_signed_in
      redirect_to signin_path unless signed_in?
    end
end
