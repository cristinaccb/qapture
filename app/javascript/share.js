function shareMedia(imagePath) {
  if (navigator.share) {
      navigator.share({
          title: 'Check out this photo!',
          text: 'I just uploaded this amazing photo on Qapture.',
          url: imagePath,
      }).then(() => {
          console.log('Thanks for sharing!');
      }).catch((error) => {
          console.error('Error sharing:', error);
      });
  } else {
      alert('Sharing not supported on this browser.');
  }
}
