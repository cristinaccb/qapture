document.addEventListener('DOMContentLoaded', function() {
  function onScanSuccess(decodedText, decodedResult) {
    // Handle the scanned code as you like
    console.log(`Code matched = ${decodedText}`, decodedResult);
    document.getElementById('qr-reader-results').innerText = `Scanned Result: ${decodedText}`;
  }

  function onScanFailure(error) {
    // Handle scan failure, usually better to ignore and keep scanning.
    console.warn(`Code scan error = ${error}`);
  }

  let html5QrcodeScanner = new Html5QrcodeScanner(
    "qr-reader", { fps: 10, qrbox: 250 });

  html5QrcodeScanner.render(onScanSuccess, onScanFailure);
});
