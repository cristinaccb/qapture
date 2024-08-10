class MessagesController < ApplicationController
  before_action :set_event

  def create
    @message = @event.messages.build(message_params)
    if @message.save
      redirect_to @event, notice: 'Your message was successfully posted.'
    else
      redirect_to @event, alert: 'There was an error posting your message.'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
