class MessagesController < ApplicationController
  before_action :set_event
  before_action :set_message, only: [:destroy]

  def new
    @message = @event.messages.build
  end

  def create
    @message = @event.messages.build(message_params)
    @message.user = current_user if user_signed_in?
    if @message.save
      redirect_to @event, notice: 'Your message was successfully posted.'
    else
      render :new, alert: 'There was an error posting your message.'
    end
  end

  def destroy
    @message.destroy
    redirect_to @event, notice: 'Message was successfully deleted.'
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
