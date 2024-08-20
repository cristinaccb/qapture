class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_upload, only: [:create, :destroy]  
  def index
    @favorites = current_user.favorites
  end

  def create
    favorite = current_user.favorites.new(upload: @upload)
    if favorite.save
      redirect_back(fallback_location: root_path, notice: 'Successfully favorited!')
    else
      redirect_back(fallback_location: root_path, alert: 'Could not favorite.')
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(upload_id: @upload.id)
    if favorite&.destroy
      redirect_back(fallback_location: root_path, notice: 'Successfully unfavorited!')
    else
      redirect_back(fallback_location: root_path, alert: 'Could not unfavorite.')
    end
  end

  private

  def set_upload
    @upload = Upload.find_by(id: params[:upload_id])  # Assuming you're passing upload_id
    unless @upload
      redirect_back(fallback_location: root_path, alert: 'Upload not found.')
      return
    end
  end
end
