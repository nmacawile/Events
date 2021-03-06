class InvitesController < ApplicationController
  before_action :user_signed_in, only: [:new, :create]
  before_action :user_can_invite, only: [:new, :create]
  before_action :invitee_exists, only: :create
  before_action :invitee_is_already_attending, only: :create
  before_action :invite_has_already_been_sent, only: :create
  
  def new
    @event = Event.find(params[:event_id])
    @users = User.where("id NOT IN (?)", @event.attendees.map(&:id))
  end
  
  def create
    @invite = Invite.new(invite_params)
    @invite.inviter = current_user
    @invite.event_id = params[:event_id]
    if @invite.save
      redirect_to event_path(params[:event_id])
    else
      render "new"
    end
  end

  def show
  end
  
  private
    def invite_params
      params.require(:invite).permit(:invitee_id)
    end
    
    def user_can_invite
      redirect_to event_path(params[:event_id]) unless current_user.attending?(params[:event_id])
    end
    
    def user_signed_in
      redirect_to signin_path unless signed_in?
    end
    
    def invitee_exists
      existing = User.exists? params[:invite][:invitee_id]
      redirect_to new_event_invite_path unless existing
    end
    
    def invitee_is_already_attending
      invitee = User.find(params[:invite][:invitee_id])
      redirect_to event_path(params[:event_id]) if invitee.attending?(params[:event_id])
    end
    
    def invite_has_already_been_sent
      redirect_to event_path(params[:event_id]) if invite_exists?(params[:event_id], params[:invite][:invitee_id])
    end
end
