Docker-Origami + Git + Konpilatu + Photobooth

Deskribapena

Proiektuak kudeatzeko txantiloi publikoa eta modulargarria honetarako:
	•	Snapshot-ak eta metadatu garbiketa (Photobooth)
	•	Git-ekin bertsio-kontrol automatikoa
	•	Docker integrazioa ingurune isolatuetarako
	•	Proiektuaren konpilazio aukerakoa
	•	Lan-ingurune karpeten konpresioa eta biltegiratzea

Garapen ingurune errepikagarrietarako eta lan-fluxu automatizaziorako egokia.

⸻

Eskakizunak
	•	Bash 5 edo berriagoa
	•	Docker (aukera, DOCKER_AUTO erabiltzeko bakarrik)
	•	Git instalatuta
	•	Konpresio tresnak (zip, tar, 7z COMPRESS_FORMAT-en arabera)
	•	Make, cargo, go, npm edo python (COMPILE_AUTO gaituta badago eta COMPILE_CMD-ren arabera)

⸻

Paindu-Paindu Erabilera

1. Hasierako Konfigurazioa

Aldagai hauek egokitu ditzakezu script-a exekutatu aurretik edo ingurune aldagaien moduan esportatu:

export COMPRESS_TARGET="data"           # Kudeatu nahi den karpeta
export COMPRESS_FORMAT="zip"            # zip/tar.gz/7z
export COMPRESS_LEVEL="6"               # Konpresio maila 1-9
export GIT_AUTO="true"                  # Git automatikoa gaituta
export DOCKER_AUTO="false"              # Docker automatikoa gaituta
export DOCKER_IMAGE="ubuntu:latest"     # Erabiliko den Docker irudia
export DOCKER_WORKSPACE="/workspace"    # Edukiontzi barruko direktorioa
export COMPILE_AUTO="false"             # Konpilazio automatikoa gaituta
export COMPILE_CMD="make"               # Konpilazio komandoa
export FOTOMATON_AUTO="true"            # Metadatuak automatikoki garbitzea

2. Exekuzio Oinarrizkoa

./docker_origami.sh

Script-ak hurrengoak egingo ditu:
	•	Karpetaren snapshot hasierako bat hartuko du
	•	Artxibo existitzen bada deskonprimatuko du
	•	Git biltegia hasiko edo eguneratuko du
	•	Docker edukiontzi bat abiaraziko du DOCKER_AUTO aktibatuta badago
	•	Adibide komandoak exekutatuko ditu edukiontzian edo hostean
	•	Metadatu desegokiak garbituko ditu
	•	Proiektua konpilatuko du COMPILE_AUTO aktibatuta badago
	•	Karpetaren azken konpresioa eta garbiketa egingo ditu

3. Adibide Komandoak

Git Automatikoa
	•	Git historia sortzen du existitzen ez bada
	•	Lanaren aurretik eta ondoren auto-commit-ak egiten ditu

Docker

docker_exec ls -la
docker_exec echo "Hello from Docker!" > test_docker.txt
docker_exec cat test_docker.txt

Host

ls -la "$COMPRESS_TARGET"
echo "Hello from Host!" > "$COMPRESS_TARGET/test_host.txt"
cat "$COMPRESS_TARGET/test_host.txt"

Konpilazio Aukerakoa

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

4. Garbiketa eta Snapshot Azkarrak
	•	Karpetaren snapshot azkarrak
	•	Metadatuak automatikoki garbituta
	•	Karpetak konprimatu eta biltegiratzeko edo banatzeko prest

⸻

Oharra
	•	Konpresio formatu anitz onartzen ditu: zip, tar.gz, 7z
	•	Partzialki exekutatu daiteke Docker edo konpilaziorik gabe
	•	Modularra: erabiltzailearen komando-blokea zure lan-fluxuaren arabera aldatu dezakezu
	•	Irekia: zure lan-fluxua egokitu eta partekatu dezakezu

⸻

**Eto Demerzel** (Gustavo Silva Da Costa)
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
