class MessagesController < ApplicationController
  before_action :set_event

  def new
    @message = @event.messages.build
  end

  def create
    @message = @event.messages.build(message_params)
    if @message.save
      redirect_to @event, notice: 'Your message was successfully posted.'
    else
      render :new, alert: 'There was an error posting your message.'
    end
  end

  def index
    @messages = @event.messages
  end

  private

  def set_event
    @event = Event.find(1)
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
