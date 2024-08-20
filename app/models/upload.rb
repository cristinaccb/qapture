class Upload < ApplicationRecord
  belongs_to :user
  belongs_to :event
  # Add CarrierWave for file uploads
  mount_uploader :file, FileUploader
    has_many :favorites
    has_many :favorited_by_users, through: :favorites, source: :user
  # Remove the extra 'end' keyword
end
