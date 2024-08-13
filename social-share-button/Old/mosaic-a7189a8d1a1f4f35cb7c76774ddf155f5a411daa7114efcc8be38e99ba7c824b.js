document.addEventListener('DOMContentLoaded', function() {
  // Mock data - in production, this would be fetched from the server
  const mosaics = [
      { id: 1, title: 'Summer Festival', imageUrl: 'path/to/image1.jpg' },
      { id: 2, title: 'Winter Concert', imageUrl: 'path/to/image2.jpg' },
      { id: 3, title: 'Company Retreat', imageUrl: 'path/to/image3.jpg' }
  ];

  const gallery = document.getElementById('mosaic-gallery');
  mosaics.forEach(mosaic => {
      const item = document.createElement('div');
      item.className = 'mosaic-item';
      item.innerHTML = `
          <img src="${mosaic.imageUrl}" alt="${mosaic.title}">
          <div class="title">${mosaic.title}</div>
      `;
      gallery.appendChild(item);
  });
});
