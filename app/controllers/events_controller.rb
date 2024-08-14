class EventsController < ApplicationController
  require 'zip'
  before_action :set_event, only: [:show, :edit, :update, :destroy, :qr_code, :guests, :manage_uploads, :download_album]

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
    @message = @event.messages # Fetch associated messages
  end

  def guests
    @qr_code = @event.qr_code
    qr = RQRCode::QRCode.new(@qr_code.qrCodeUrl)
    @qr_code_svg = qr.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 6,
      standalone: true
    ).html_safe
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
    # @event is already set by the before_action
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

  def qr_code
    @qr_code = @event.qr_code
    qr = RQRCode::QRCode.new(@qr_code.qrCodeUrl)
    @qr_code_svg = qr.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 6,
      standalone: true
    ).html_safe
  end

  def download_selected
    @event = Event.find(params[:event_id])
    selected_uploads = Upload.where(id: params[:selected_uploads])

    zip_file = package_uploads_as_zip(selected_uploads)

    send_file(zip_file, type: 'application/zip', disposition: 'attachment')
  end

  def download_album
    @uploads = @event.uploads

    if @uploads.empty?
      redirect_to @event, alert: 'There are no files to download for this event.'
      return
    end

    zipfile_name = "#{Rails.root}/tmp/#{@event.name.parameterize}_album.zip"

    begin
      Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
        @uploads.each do |upload|
          file_path = upload.file.path # Adjust this based on how you store files
          zipfile.add(File.basename(file_path), file_path) if File.exist?(file_path)
        end
      end

      send_file zipfile_name, type: 'application/zip', disposition: 'attachment'
    ensure
      File.delete(zipfile_name) if zipfile_name && File.exist?(zipfile_name)
    end
  end

  def manage_uploads
    @uploads = @event.uploads.to_a
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

  def set_event
    @event = Event.find_by(id: params[:id])
    unless @event
      flash[:alert] = "Event not found"
      redirect_to events_path
    end
  end


  def event_params
    params.require(:event).permit(:name, :date, :location, :host, :file)
  end
end
