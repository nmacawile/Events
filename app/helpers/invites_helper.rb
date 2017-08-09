module InvitesHelper
  def invite_exists?(event_id, invitee_id)
    Invite.exists?(event_id: event_id, invitee_id: invitee_id, inviter_id: current_user.id)
  end
end
