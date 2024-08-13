function toggleSnippet(element) {
  const activeClass = 'active';
  const snippets = document.querySelectorAll('.menu-item');
  snippets.forEach(item => {
      if (item !== element) {
          item.classList.remove(activeClass);
      }
  });
  element.classList.toggle(activeClass);
};
