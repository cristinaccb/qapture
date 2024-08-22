document.addEventListener('turbolinks:load', () => {
  const images = document.querySelectorAll('.image-container');

  images.forEach(image => {
    let lastTap = 0;

    image.addEventListener('touchstart', function(e) {
      const currentTime = new Date().getTime();
      const tapLength = currentTime - lastTap;

      if (tapLength < 500 && tapLength > 0) {
        e.preventDefault();
        toggleFavorite(this);
      }

      lastTap = currentTime;
    });
  });
});

function toggleFavorite(imageElement) {
  const imageId = imageElement.dataset.imageId;
  const favoriteIcon = imageElement.querySelector('.favorite-icon');
  const isFavorited = favoriteIcon.classList.contains('favorited');

  const url = isFavorited ? `/favorites/${imageId}` : '/favorites';
  const method = isFavorited ? 'DELETE' : 'POST';

  fetch(url, {
    method: method,
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
    },
    body: JSON.stringify({ image_id: imageId })
  })
  .then(response => response.json())
  .then(data => {
    if (data.status === 'success') {
      favoriteIcon.classList.toggle('favorited');
      animateFavorite(favoriteIcon);
    }
  })
  .catch(error => console.error('Error:', error));
}

function animateFavorite(favoriteIcon) {
  favoriteIcon.classList.add('animate');
  setTimeout(() => favoriteIcon.classList.remove('animate'), 1000);
}
