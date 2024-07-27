class Upload < ApplicationRecord
  belongs_to :user
  belongs_to :event
  # Add CarrierWave for file uploads
  mount_uploader :file, FileUploader
end
