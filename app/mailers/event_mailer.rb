class EventMailer < ApplicationMailer

  default from: "[WALKABOUT Bot] <noreply@yourdomain.com>"


  def new_event(event, set_account)
    @event = event
  
    mail(to: set_account.email, subject: "[APPT] From: #{@event.name}", body: "Hi, #{set_account.name}. #{@event.name} is interested in scheduling
    	a #{@event.type} shoot on #{@event.date_one} or #{@event.date_two}, or #{@event.date_three}. Please email #{@event.name} @ #{@event.email}")
  end
end
