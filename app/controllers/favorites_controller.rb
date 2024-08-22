class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_upload, only: [:create, :destroy]
  def index
    @favorites = current_user.favorites
  end

  def create
    @favorite = current_user.favorites.build(image_id: params[:image_id])
    if @favorite.save
      render json: { status: 'success', favorite: @favorite }
    else
      render json: { status: 'error', errors: @favorite.errors.full_messages }
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(image_id: params[:image_id])
    if @favorite&.destroy
      render json: { status: 'success' }
    else
      render json: { status: 'error', message: 'Favorite not found' }
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
