// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

//= require social-share-button

import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener('DOMContentLoaded', () => {
  const menuToggle = document.getElementById('qr-options-button');
  const dropdownMenu = document.getElementById('qr-options-menu');

  menuToggle.addEventListener('click', () => {
      dropdownMenu.style.display = dropdownMenu.style.display === 'none' ? 'block' : 'none';
  });

  function createOrUpdateQR() {
      fetch('<%= event_qr_code_path(@event) %>', { method: 'GET' })
          .then(response => response.json()) // Parse the response as JSON
          .then(data => {
              document.getElementById('qr-code-container').innerHTML = data.qr_code;
          })
          .catch(error => console.error('Error generating QR code:', error)); // Log any errors to the console
  }

  function printQRCode() {
      const qrContainer = document.getElementById('qr-code-container');
      if (qrContainer) {
          const qrCodeWindow = window.open('', '_blank');
          qrCodeWindow.document.write('<html><head><title>Print QR Code</title></head><body>');
          qrCodeWindow.document.write(qrContainer.innerHTML);
          qrCodeWindow.document.write('</body></html>');
          qrCodeWindow.document.close();
          qrCodeWindow.print();
      }
  }

  function shareQRCode() {
      const qrContainer = document.getElementById('qr-code-container');
      if (navigator.share && qrContainer) {
          const qrCodeDataUrl = qrContainer.querySelector('img').src; // Assuming the QR code is an <img> tag
          navigator.share({
              title: 'QR Code',
              text: 'Check out this QR code for the event!',
              url: qrCodeDataUrl
          }).catch(error => console.error('Error sharing QR code:', error));
      } else {
          alert('Sharing is not supported on this browser.');
      }
  }
});
