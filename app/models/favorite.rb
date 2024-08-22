class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :upload
  belongs_to :image
end
