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
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Event was successfully deleted.' }
      format.json { head :no_content }
    end
  end


  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :date, :location, :host, :file) # Include :file here for upload functionality
  end

  require 'zip'

  class EventsController < ApplicationController
    # Other actions...

    def download_selected
      @event = Event.find(params[:event_id])
      selected_uploads = Upload.where(id: params[:selected_uploads])

      zip_file = package_uploads_as_zip(selected_uploads)

      send_file(zip_file, type: 'application/zip', disposition: 'attachment')
    end

    private

    def package_uploads_as_zip(uploads)
      temp_file = Tempfile.new("uploads-#{Time.now.to_i}.zip")
      Zip::File.open(temp_file.path, Zip::File::CREATE) do |zipfile|
        uploads.each do |upload|
          file_path = upload.file.path # Assuming you have a file path stored in upload.file
          zipfile.add(File.basename(file_path), file_path) if File.exist?(file_path)
        end
      end
      temp_file.path
    ensure
      temp_file.close
    end
  end

end
