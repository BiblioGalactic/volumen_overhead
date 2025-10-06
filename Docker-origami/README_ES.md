Docker-Origami + Git + Compile + Fotomatón

Descripción

Plantilla pública y modular para manejar proyectos con:
	•	Snapshots y limpieza de metadata (Fotomatón)
	•	Control de versiones automático con Git
	•	Integración con Docker para entorno aislado
	•	Compilación opcional de proyectos
	•	Compresión y almacenamiento de carpetas de trabajo

Ideal para entornos de desarrollo reproducibles y automatización de flujo de trabajo.

⸻

Requisitos
	•	Bash 5 o superior
	•	Docker (opcional, solo si deseas usar Docker_AUTO)
	•	Git instalado
	•	Herramientas de compresión (zip, tar, 7z según COMPRESS_FORMAT)
	•	Make, cargo, go, npm o python (según COMPILE_CMD si habilitas COMPILE_AUTO)

⸻

Uso paso a paso

1. Configuración inicial

Puedes ajustar estas variables antes de ejecutar el script o exportarlas como variables de entorno:

export COMPRESS_TARGET="data"           # Carpeta a manejar
export COMPRESS_FORMAT="zip"            # zip/tar.gz/7z
export COMPRESS_LEVEL="6"               # Nivel de compresión 1-9
export GIT_AUTO="true"                  # Activar git automático
export DOCKER_AUTO="false"              # Activar Docker automático
export DOCKER_IMAGE="ubuntu:latest"     # Imagen Docker a usar
export DOCKER_WORKSPACE="/workspace"    # Directorio dentro del container
export COMPILE_AUTO="false"             # Activar compilación automática
export COMPILE_CMD="make"               # Comando de compilación
export FOTOMATON_AUTO="true"            # Limpiar metadata automáticamente

2. Ejecución básica

./docker_origami.sh

El script hará lo siguiente:
	•	Tomar un snapshot inicial de la carpeta
	•	Descomprimir si existe un archivo comprimido
	•	Inicializar o actualizar el repositorio Git
	•	Iniciar un container Docker si DOCKER_AUTO está activo
	•	Ejecutar comandos de ejemplo dentro del container o host
	•	Limpiar metadata innecesaria
	•	Compilar el proyecto si COMPILE_AUTO está activo
	•	Comprimir y limpiar la carpeta final

3. Ejemplos de comandos

Git automático
	•	Crea un historial Git si no existe
	•	Commit automático antes y después del trabajo

Docker

docker_exec ls -la
docker_exec echo "Hello from Docker!" > test_docker.txt
docker_exec cat test_docker.txt

Host

ls -la "$COMPRESS_TARGET"
echo "Hello from Host!" > "$COMPRESS_TARGET/test_host.txt"
cat "$COMPRESS_TARGET/test_host.txt"

Compilación opcional

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

4. Limpieza y snapshots finales
	•	Snapshots finales de la carpeta
	•	Metadata limpiada automáticamente
	•	Carpeta comprimida y lista para almacenamiento o distribución

⸻

Notas
	•	Compatible con diferentes formatos de compresión: zip, tar.gz, 7z
	•	Puede ejecutarse parcialmente sin Docker ni compilación
	•	Modular: puedes modificar el bloque de comandos del usuario según tus necesidades
	•	Open-source: adapta y comparte tu flujo de trabajo

⸻

**Eto Demerzel** (Gustavo Silva Da Costa)
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
