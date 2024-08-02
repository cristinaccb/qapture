class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
    @qr_code = @event.qr_code
    qr = RQRCode::QRCode.new(@qr_code.qrCodeUrl)
    @qr_code_svg = qr.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 6,
      standalone: true
    ).html_safe

    @upload = @event.uploads.build # Initializes a new Upload object linked to this event
    @recent_events = Event.order(created_at: :desc).limit(5) # Add this line to provide recent events
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :date, :location, :host, :file) # Include :file here for upload functionality
  end
end
