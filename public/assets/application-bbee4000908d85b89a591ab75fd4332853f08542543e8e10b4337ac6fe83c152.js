// Importmap configuration
import "@hotwired/turbo-rails"
import "controllers"

// Stimulus setup
import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }

// QR Code Menu Toggle
document.addEventListener('DOMContentLoaded', () => {
  const menuToggle = document.getElementById('qr-options-button');
  const dropdownMenu = document.getElementById('qr-options-menu');

  if (menuToggle && dropdownMenu) {
    menuToggle.addEventListener('click', () => {
      dropdownMenu.style.display = dropdownMenu.style.display === 'none' ? 'block' : 'none';
    });
  }

  // QR Code generation and printing
  function createOrUpdateQR() {
    fetch('<%= event_qr_code_path(@event) %>', { method: 'GET' })
      .then(response => response.json())
      .then(data => {
        document.getElementById('qr-code-container').innerHTML = data.qr_code;
      })
      .catch(error => console.error('Error generating QR code:', error));
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

  // Scrolling Text
  const scrollingText = document.getElementById('scrolling-text');
  if (scrollingText) {
    const scrollSpan = scrollingText.querySelector('span');

    function continuousScroll() {
      const spanWidth = scrollSpan.offsetWidth;
      const containerWidth = scrollingText.offsetWidth;
      const totalScrollWidth = containerWidth + spanWidth;

      scrollSpan.style.transform = `translateX(${containerWidth}px)`;

      scrollSpan.animate(
        [
          { transform: `translateX(${containerWidth}px)` },
          { transform: `translateX(-${spanWidth}px)` }
        ],
        {
          duration: totalScrollWidth * 15, // Adjust speed by changing the multiplier
          iterations: Infinity,
          easing: 'linear'
        }
      );
    }

    continuousScroll();
  }
});
