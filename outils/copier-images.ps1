# Copie l'image principale de chaque fiche projet depuis la sauvegarde FTP de l'ancien WordPress.
#
# Utilisation, depuis le dossier du site, dans PowerShell :
#   .\outils\copier-images.ps1 -Sauvegarde "C:\chemin\vers\la\sauvegarde-ftp"
#
# -Sauvegarde : le dossier qui contient « www » (la racine de l'hébergement téléchargée par FTP).
# Si Windows refuse d'exécuter le script : Set-ExecutionPolicy -Scope Process Bypass

param([Parameter(Mandatory = $true)][string]$Sauvegarde)

$uploads = Join-Path $Sauvegarde "www\wp-content\uploads"
if (-not (Test-Path $uploads)) { Write-Error "Dossier introuvable : $uploads"; exit 1 }

$site = Split-Path $PSScriptRoot -Parent
$liste = Import-Csv (Join-Path $PSScriptRoot "images-a-copier.csv") -Delimiter ";" -Encoding UTF8
$ok = 0; $manquantes = @()

foreach ($l in $liste) {
  $source = Join-Path $uploads ($l.image -replace "/", "\")
  # On préfère l'original en grande taille, que WordPress garde sans le suffixe (-810x540, -scaled…)
  $orig = $source -replace "-\d+x\d+(?=\.\w+$)", "" -replace "-scaled(?=\.\w+$)", ""
  if (($orig -ne $source) -and (Test-Path $orig)) { $source = $orig }
  if (Test-Path $source) {
    $ext = [IO.Path]::GetExtension($source).ToLower()
    $dest = Join-Path $site ("content\projets\" + $l.fiche + "\image" + $ext)
    Copy-Item $source $dest -Force
    $ok++
  } else {
    $manquantes += "$($l.fiche) : $($l.image)"
  }
}

Write-Host "$ok images copiées."
if ($manquantes.Count) {
  Write-Host "`nIntrouvables ($($manquantes.Count)) : à copier à la main, sous le nom image.jpg dans le dossier de la fiche :" -ForegroundColor Yellow
  $manquantes | ForEach-Object { Write-Host "  $_" }
}
