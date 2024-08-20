class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_upload, only: [:create, :destroy]

  def favorite
    current_user.favorite_uploads << @upload
    redirect_back fallback_location: event_uploads_path(@upload.event), notice: 'Upload has been favorited.'
  end

  def unfavorite
    current_user.favorite_uploads.delete(@upload)
    redirect_back fallback_location: event_uploads_path(@upload.event), notice: 'Upload has been unfavorited.'
  end

  private

  def set_upload
    @upload = Upload.find(params[:id])


  end
end
