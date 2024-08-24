class UploadsController < ApplicationController
  before_action :set_event
  before_action :set_upload, only: [:show, :edit, :update, :destroy, :generate_caption, :post_to_social_media]

  def index
    @uploads = @event.uploads
    @messages = @event.messages
  end

  def show
  end

  def new
    @upload = @event.uploads.build
  end

  def favorite
    current_user.favorite_uploads << @upload
    redirect_to event_uploads_path(@event), notice: 'You have favorited this upload.'
  end

  def unfavorite
    current_user.favorite_uploads.delete(@upload)
    redirect_to event_uploads_path(@event), notice: 'Upload has been unfavorited.'
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
# app/controllers/uploads_controller.rb
def generate_caption
  file_name = @upload.file.filename.to_s
  image_description = "an image named #{file_name}"

  caption = OllamaApi.generate_instagram_caption(image_description)

  if caption.present?
    @upload.update(caption: caption)
    redirect_to event_upload_path(@upload.event, @upload), notice: 'Instagram caption generated successfully.'
  else
    redirect_to event_upload_path(@upload.event, @upload), alert: 'Failed to generate Instagram caption. Please try again.'
  end
end

  def post_to_social_media
    result = SocialMediaService.post_caption(@upload.caption) # Hypothetical service
    if result.success?
      flash[:notice] = "Caption posted to social media successfully!"
    else
      flash[:alert] = "Failed to post caption to social media."
    end
    redirect_to event_upload_path(@event, @upload)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, alert: 'Event not found.'
  end

  def set_upload
    @upload = @event.uploads.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to event_uploads_path(@event), alert: "Upload not found."
  end

  def upload_params
    params.require(:upload).permit(:file)
  end
end
