// Filtres de la page Projets. Sans JavaScript, tous les projets restent visibles.
(function () {
  var groupe = document.querySelector('.filtres');
  if (!groupe) return;
  groupe.hidden = false;
  var tuiles = document.querySelectorAll('.tuile');
  groupe.addEventListener('click', function (e) {
    var b = e.target.closest('button');
    if (!b) return;
    groupe.querySelectorAll('button').forEach(function (x) { x.setAttribute('aria-pressed', x === b); });
    var f = b.dataset.filtre;
    tuiles.forEach(function (t) {
      t.hidden = f && t.dataset.disciplines.split(' ').indexOf(f) === -1;
    });
  });
})();
