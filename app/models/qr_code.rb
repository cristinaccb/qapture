class QrCode < ApplicationRecord
  belongs_to :event

  before_create :generate_qr_code_data

  private

  def generate_qr_code_data
    self.qrCodeUrl = event_url(self.event)
  end

  def event_url(event)
    Rails.application.routes.url_helpers.url_for({controller: "events", action: "show", id: event.id, only_path: false})
  end
end

