Docker-Origami + Git + Compilation + Photomaton

Description

Modèle public et modulaire pour gérer des projets avec :
	•	Snapshots et nettoyage des métadonnées (Photomaton)
	•	Contrôle de version automatique avec Git
	•	Intégration de Docker pour un environnement isolé
	•	Compilation optionnelle des projets
	•	Compression et archivage des dossiers de travail

Idéal pour les environnements de développement reproductibles et l’automatisation des flux de travail.

⸻

Prérequis
	•	Bash 5 ou supérieur
	•	Docker (optionnel, uniquement si vous souhaitez utiliser Docker_AUTO)
	•	Git installé
	•	Outils de compression (zip, tar, 7z selon COMPRESS_FORMAT)
	•	make, cargo, go, npm ou python (selon COMPILE_CMD si COMPILE_AUTO est activé)

⸻

Utilisation étape par étape

1. Configuration initiale

Vous pouvez ajuster ces variables avant d’exécuter le script ou les exporter comme variables d’environnement :

export COMPRESS_TARGET="data"           # Dossier à gérer
export COMPRESS_FORMAT="zip"            # zip/tar.gz/7z
export COMPRESS_LEVEL="6"               # Niveau de compression 1–9
export GIT_AUTO="true"                  # Activer Git automatique
export DOCKER_AUTO="false"              # Activer Docker automatique
export DOCKER_IMAGE="ubuntu:latest"     # Image Docker à utiliser
export DOCKER_WORKSPACE="/workspace"    # Répertoire dans le conteneur
export COMPILE_AUTO="false"             # Activer la compilation automatique
export COMPILE_CMD="make"               # Commande de compilation
export FOTOMATON_AUTO="true"            # Nettoyage automatique des métadonnées


⸻

2. Exécution basique

./docker_origami.sh

Le script effectuera les actions suivantes :
	•	Prendre un snapshot initial du dossier
	•	Décompresser s’il existe un fichier compressé
	•	Initialiser ou mettre à jour le dépôt Git
	•	Démarrer un conteneur Docker si DOCKER_AUTO est activé
	•	Exécuter les commandes d’exemple dans le conteneur ou sur l’hôte
	•	Nettoyer les métadonnées inutiles
	•	Compiler le projet si COMPILE_AUTO est activé
	•	Compresser et nettoyer le dossier final

⸻

3. Exemples de commandes

Git automatique
	•	Crée un historique Git s’il n’existe pas
	•	Commit automatique avant et après le travail

Docker

docker_exec ls -la
docker_exec echo "Hello from Docker!" > test_docker.txt
docker_exec cat test_docker.txt

Hôte

ls -la "$COMPRESS_TARGET"
echo "Hello from Host!" > "$COMPRESS_TARGET/test_host.txt"
cat "$COMPRESS_TARGET/test_host.txt"

Compilation optionnelle

# C/C++
COMPILE_AUTO=true COMPILE_CMD="make release"
# Rust
COMPILE_AUTO=true COMPILE_CMD="cargo build --release"
# Go
COMPILE_AUTO=true COMPILE_CMD="go build -o app main.go"
# Node.js
COMPILE_AUTO=true COMPILE_CMD="npm run build"
# Python
COMPILE_AUTO=true COMPILE_CMD="python setup.py build"


⸻

4. Nettoyage et snapshots finaux
	•	Snapshots finaux du dossier
	•	Métadonnées nettoyées automatiquement
	•	Dossier compressé, prêt à être archivé ou distribué

⸻

Notes
	•	Compatible avec différents formats de compression : zip, tar.gz, 7z
	•	Peut être exécuté partiellement sans Docker ni compilation
	•	Modulaire : vous pouvez modifier le bloc de commandes utilisateur selon vos besoins
	•	Open source : adaptez et partagez votre flux de travail

⸻

Eto Demerzel (Gustavo Silva Da Costa)
https://etodemerzel.gumroad.com￼
https://github.com/BiblioGalactic￼

