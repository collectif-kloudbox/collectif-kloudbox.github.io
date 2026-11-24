// Lecteur au clic : remplace l'aperçu par le lecteur YouTube ou Vimeo seulement quand on clique.
document.querySelectorAll('.video-lien').forEach(function (lien) {
  lien.addEventListener('click', function (e) {
    e.preventDefault();
    var id = lien.dataset.id, src;
    if (lien.dataset.service === 'vimeo') {
      src = 'https://player.vimeo.com/video/' + id + '?autoplay=1&dnt=1';
    } else {
      src = 'https://www.youtube-nocookie.com/embed/' + id + '?autoplay=1&rel=0';
    }
    var f = document.createElement('iframe');
    f.src = src;
    f.title = lien.textContent.trim();
    f.allow = 'autoplay; fullscreen; picture-in-picture';
    f.allowFullscreen = true;
    lien.replaceWith(f);
  });
});
