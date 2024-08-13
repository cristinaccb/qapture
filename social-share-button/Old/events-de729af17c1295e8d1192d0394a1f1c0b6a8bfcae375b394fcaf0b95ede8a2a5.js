document.addEventListener('DOMContentLoaded', function() {
  const qrOptionsButton = document.getElementById('qr-options-button');
  const qrOptionsMenu = document.getElementById('qr-options-menu');

  if (qrOptionsButton && qrOptionsMenu) {
    qrOptionsButton.addEventListener('click', function() {
      qrOptionsMenu.style.display = qrOptionsMenu.style.display === 'none' ? 'block' : 'none';
    });
  }
});

function createOrUpdateQR() {
  const eventId = document.querySelector('meta[name="event-id"]').content;
  fetch(`/events/${eventId}/qr_code`, {
    method: 'GET',
    headers: {
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
      'Accept': 'application/json'
    }
  })
  .then(response => {
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    return response.json();
  })
  .then(data => {
    document.getElementById('qr-code-container').innerHTML = data.qr_code;
  })
  .catch(error => {
    console.error('Error generating QR code:', error);
    alert('Failed to generate QR code. Please try again.');
  });
}

function printQRCode() {
  const qrCodeContainer = document.getElementById('qr-code-container');
  const printWindow = window.open('', '', 'height=500,width=500');
  printWindow.document.write('<html><head><title>Print QR Code</title></head><body>');
  printWindow.document.write(qrCodeContainer.innerHTML);
  printWindow.document.write('</body></html>');
  printWindow.document.close();
  printWindow.print();
}

function shareQRCode() {
  // Implement share functionality
  // This could open a modal with sharing options or use the Web Share API if supported
  alert('Sharing functionality to be implemented');
};
