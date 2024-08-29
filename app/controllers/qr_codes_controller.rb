class QrCodeController < ApplicationRecord
  belongs_to :event

  before_create :generate_qr_code_data

  private

  def generate_qr_code_data
    qr = RQRCode::QRCode.new(event_url(self.event))
    self.qr_code_data = qr.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 6,
      standalone: true
    ).html_safe
  end

  def event_url(event)
    Rails.application.routes.url_helpers.event_url(event)

  end
end
