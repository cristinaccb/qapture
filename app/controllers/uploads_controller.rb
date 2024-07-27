class UploadsController < ApplicationController
  before_action :set_user, only: [:index, :new, :create]
  before_action :set_event, only: [:index, :new, :create]
  before_action :set_upload, only: [:show, :edit, :update, :destroy]

  def index
    @uploads = if @user
                 @user.uploads
               elsif @event
                 @event.uploads
               else
                 Upload.all
               end
  end

  def show
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = if @user
                @user.uploads.build(upload_params)
              elsif @event
                @event.uploads.build(upload_params)
              else
                Upload.new(upload_params)
              end

    if @upload.save
      redirect_to @upload, notice: 'Upload was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @upload.update(upload_params)
      redirect_to @upload, notice: 'Upload was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @upload.destroy
    redirect_to uploads_url, notice: 'Upload was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end

  def set_event
    @event = Event.find(params[:event_id]) if params[:event_id]
  end

  def set_upload
    @upload = Upload.find(params[:id])
  end

  def upload_params
    params.require(:upload).permit(:file, :description)
  end
end
