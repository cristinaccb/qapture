class UploadsController < ApplicationController
  before_action :set_event
  before_action :set_upload, only: [:show, :edit, :update, :destroy]

  def index
    @uploads = @event.uploads
  end

  def show
  end

  def new
    @upload = @event.uploads.build
  end

  def create
    @upload = @event.uploads.build(upload_params)
    @upload.user_id = current_user.id
    if @upload.save
      redirect_to event_uploads_path(@event), notice: 'Upload was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @upload.update(upload_params)
      redirect_to event_upload_path(@event, @upload), notice: 'Upload was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @upload.destroy
    redirect_to event_uploads_path(@event), notice: 'Upload was successfully destroyed.'
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_upload
    @upload = @event.uploads.find(params[:id])
  end

  def upload_params
    params.require(:upload).permit(:file)
  end
end
