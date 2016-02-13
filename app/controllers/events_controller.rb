class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    
    if @event.valid?
      EventMailer.new_event(@event).deliver
      redirect_to contact_path, notice: "Your messages has been sent."
    else
      flash[:alert] = "An error occurred while delivering this message."
      render :new
    end
  end

private

  def event_params
    params.require(:event).permit(:name, :email, :type, :date_one, :date_two, :date_three)
  end

end
