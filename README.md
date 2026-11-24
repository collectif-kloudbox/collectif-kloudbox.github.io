# kloudbox.com

Site du collectif KloudBox, construit avec [Hugo](https://gohugo.io) et publié par GitHub Pages.
À chaque envoi (`git push`) sur la branche `main`, GitHub construit le site et le met en ligne tout seul, en une à deux minutes.

## Où est quoi

| Je veux modifier… | Fichier |
|---|---|
| Le texte d'accueil | `layouts/home.html` |
| Les projets affichés sur l'accueil | `accueil: true` dans la fiche du projet |
| Une fiche projet | `content/projets/<nom>/index.md` |
| L'image d'une fiche | `content/projets/<nom>/image.jpg` (ou `.png`) |
| Les mentions légales | `content/mentions-legales.md` |
| Les couleurs et la mise en forme | `static/assets/style.css` |
| Le logo et les icônes | `static/assets/`, `static/favicon.*` |

## Une fiche projet

Chaque projet est un dossier dans `content/projets/`, avec un `index.md` et, si possible, une `image.jpg` :

```yaml
---
title: "Le Miracle de Kamaishi"
annee: 2019                 # sert au tri ; laisser vide si inconnue
annee_debut: 2014           # facultatif, pour une période (« 2014 – 2020 »)
disciplines: ["Documentaires"]
en_avant: true              # vignette deux fois plus grande dans la grille
accueil: true               # affiché dans « Quelques projets » sur l'accueil
resume: "Une phrase, affichée sur l'accueil et dans les partages"
videos:                     # YouTube ou Vimeo, chargés seulement au clic
  - service: "youtube"
    id: "KrAlpT9SVno"
aliases: ["/documentaire/le-miracle-de-kamaishi/"]   # anciennes adresses du WordPress
draft: true                 # facultatif : la fiche existe mais n'est pas publiée
---

Le texte de la fiche, en Markdown. Un retour à la ligne dans le texte = un retour à la ligne sur la page.
```

Disciplines utilisées : Clips, Courts-métrages, Documentaires, Pub & photo, Scène & événements, Expositions, Édition, Numérique.
Les filtres de la page Projets se construisent tout seuls à partir de ces valeurs.

## 1. Récupérer les images (une seule fois)

Les fiches attendent leur image principale. Le script la copie depuis ta sauvegarde FTP :

```powershell
.\outils\copier-images.ps1 -Sauvegarde "C:\chemin\vers\la\sauvegarde-ftp"
```

Le chemin à donner est celui du dossier qui contient `www`. Le script indique les images qu'il n'a pas trouvées.
Pour SUPERAMAS, Seuls sous les pins et Super Bingo, ajoute l'image à la main (`image.jpg` dans le dossier de la fiche).

## 2. Voir le site sur ton ordinateur (facultatif)

Installe Hugo avec `winget install Hugo.Hugo.Extended`, puis, depuis ce dossier, lance `hugo server`.
Le site s'ouvre sur http://localhost:1313 et se met à jour à chaque enregistrement.

## 3. Mise en ligne

1. Crée l'organisation GitHub du collectif, puis un dépôt public `NOM-DE-L-ORGA.github.io`.
2. Pousse ce dossier :
   ```powershell
   git init
   git add .
   git commit -m "Site KloudBox"
   git branch -M main
   git remote add origin https://github.com/NOM-DE-L-ORGA/NOM-DE-L-ORGA.github.io.git
   git push -u origin main
   ```
3. Dans le dépôt, va dans **Settings → Pages → Build and deployment → Source** et choisis **GitHub Actions**.
4. Dans l'onglet **Actions**, le workflow « Publier le site » doit passer au vert. Le site est alors visible sur `https://NOM-DE-L-ORGA.github.io`.

### Le domaine kloudbox.com

1. **Vérifie le domaine** dans les réglages de l'**organisation** (Settings → Pages → Add a domain → `kloudbox.com`), en ajoutant chez OVH la ligne `TXT` que GitHub indique.
2. **Dans la zone DNS OVH de kloudbox.com**, modifie seulement ces lignes :

| Sous-domaine | Type | Valeur |
|---|---|---|
| *(vide)* | A | 185.199.108.153 · 185.199.109.153 · 185.199.110.153 · 185.199.111.153 (4 lignes, qui remplacent 213.186.33.87) |
| *(vide)* | AAAA | 2606:50c0:8000::153 · 2606:50c0:8001::153 · 2606:50c0:8002::153 · 2606:50c0:8003::153 (4 lignes, qui remplacent celle d'OVH) |
| www | CNAME | `NOM-DE-L-ORGA.github.io.` (remplace les lignes A/AAAA de www) |

   ⚠️ Ne touche **pas** aux lignes `MX` ni aux `TXT` contenant `spf` ou `dkim` : ce sont celles de la messagerie.
3. Dans **Settings → Pages** du dépôt, *Custom domain* doit afficher `kloudbox.com` (le fichier `static/CNAME` le fait). Une fois la vérification DNS passée, coche **Enforce HTTPS**.

## À vérifier dans le contenu

Cherche `✏️` dans `content/` pour les points ouverts :
- **Mentions légales** : l'adresse du siège et le numéro RNA.
- **SUPERAMAS, Super Bingo, Seuls sous les pins** : textes courts à compléter, et l'année de l'exposition.
- **Super Bingo / Super Loto 9000** : ils partagent la même vidéo. Le Super Loto 9000 était-il la première édition en ligne ?

**Années déduites de la date de mise en ligne des images**, à confirmer :
2019 : Maras – Loup de nuit, Thom Yorke – Has Ended
2018 : ETWOG, Bonnes vacances au chômage, Bolid'ster, Rhum Saint James, Spots pub cinéma, Costello – Dotcom
2016 : Passion Supporters, Nayade Swimwear, BDA / Bruxelles, Les Gordon – Atlas, #FABZONE
2015 : Le Skate Moderne, Mi casa es tu casa, Hoosky Night Town (making of), Free Music, Hello Bye Bye, La Fine Équipe – Tarte au citron, Night Town, Kit Thomas, Orties Royales, Soirée #MaisonJager

**Sans année** (placés en fin de grille) : DDP Classic, Idéal Standard, Desillusion Magazine, Royan la rage, Copa90 Palestine, The Liberté Cup, Les fontaines de Clémence Van Lunen, Transformations, Nayade – Exotic Cartel, Histoire de la salle des fêtes du Grand Parc, Union des Grands Crus, Bonendroi.com.

**Non publiés** (`draft: true`) : Série Tabac (retiré) et la campagne de Biscarrosse (sans décision).
