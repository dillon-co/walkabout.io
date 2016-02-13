class EventMailer < ApplicationMailer

  default from: "[WALKABOUT Bot] <noreply@yourdomain.com>"
  default to: "#{set_account.name} <#{set_account.email}>"


  def new_event(event)
    @event = event
    
    mail subject: "Message from #{@event.name}"
  end
end
