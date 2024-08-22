class Event < ApplicationRecord
  has_many :uploads
  has_many :users, through: :uploads
  has_one :qr_code, dependent: :destroy
  has_many :messages, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :date, presence: true
  validates :location, presence: true

  after_create :generate_qr_code

  private

  def generate_qr_code
    self.create_qr_code
  end

  mount_uploader :file, FileUploader
  # other associations and validations
end
