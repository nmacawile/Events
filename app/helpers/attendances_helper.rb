module AttendancesHelper
  def invited_to?(event_id)
    current_user.events_invited_to.exists? event_id
  end
  
  def already_attending?(event_id)
    current_user.events_attended.exists? event_id
  end
end
