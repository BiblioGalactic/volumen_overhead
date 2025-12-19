Docker-Origami + Git + Compilar + Photobooth

Descripció

Una plantilla pública i modular per gestionar projectes amb:
	•	Captures i neteja de metadades (Photobooth)
	•	Control de versions automàtic amb Git
	•	Integració amb Docker per entorns aïllats
	•	Compilació opcional del projecte
	•	Compressió i emmagatzematge de carpetes de treball

Ideal per a entorns de desenvolupament reproduïbles i automatització de fluxos de treball.

⸻

Requisits
	•	Bash 5 o superior
	•	Docker (opcional, només si es vol utilitzar DOCKER_AUTO)
	•	Git instal·lat
	•	Eines de compressió (zip, tar, 7z segons COMPRESS_FORMAT)
	•	Make, cargo, go, npm o python (segons COMPILE_CMD si COMPILE_AUTO està activat)

⸻

Ús Pas a Pas

1. Configuració Inicial

Pots ajustar aquestes variables abans d’executar l’script o exportar-les com a variables d’entorn:

export COMPRESS_TARGET="data"           # Carpeta a gestionar
export COMPRESS_FORMAT="zip"            # zip/tar.gz/7z
export COMPRESS_LEVEL="6"               # Nivell de compressió 1-9
export GIT_AUTO="true"                  # Activa Git automàtic
export DOCKER_AUTO="false"              # Activa Docker automàtic
export DOCKER_IMAGE="ubuntu:latest"     # Imatge Docker a usar
export DOCKER_WORKSPACE="/workspace"    # Directori dins del contenidor
export COMPILE_AUTO="false"             # Activa compilació automàtica
export COMPILE_CMD="make"               # Comanda de compilació
export FOTOMATON_AUTO="true"            # Neteja automàtica de metadades

2. Execució Bàsica

./docker_origami.sh

L’script farà:
	•	Prendre una captura inicial de la carpeta
	•	Descomprimir qualsevol arxiu existent
	•	Inicialitzar o actualitzar el repositori Git
	•	Iniciar un contenidor Docker si DOCKER_AUTO està actiu
	•	Executar comandes d’exemple dins del contenidor o host
	•	Netejar metadades innecessàries
	•	Compilar el projecte si COMPILE_AUTO està actiu
	•	Comprimir i netejar la carpeta final

3. Comandes d’Exemple

Git Automàtic
	•	Crea un historial Git si no existeix
	•	Auto-commits abans i després del treball

Docker

docker_exec ls -la
docker_exec echo "Hola des de Docker!" > test_docker.txt
docker_exec cat test_docker.txt

Host

ls -la "$COMPRESS_TARGET"
echo "Hola des de Host!" > "$COMPRESS_TARGET/test_host.txt"
cat "$COMPRESS_TARGET/test_host.txt"

Compilació Opcional

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

4. Neteja Final i Captures
	•	Captures finals de la carpeta
	•	Metadades netejades automàticament
	•	Carpeta comprimida i preparada per emmagatzematge o distribució

⸻

Notes
	•	Suporta múltiples formats de compressió: zip, tar.gz, 7z
	•	Es pot executar parcialment sense Docker o compilació
	•	Modular: pots modificar el bloc de comandes d’usuari per adaptar-lo al teu flux
	•	Codi obert: adapta i comparteix el teu flux de treball

⸻

**Eto Demerzel** (Gustavo Silva Da Costa)
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
