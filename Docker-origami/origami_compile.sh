#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# ========================================
# Docker-Origami + Git + Compile + Fotomatón
# Public, modular and configurable template
# ========================================

# === Configuración pública ===
COMPRESS_TARGET="${COMPRESS_TARGET:-data}"
COMPRESS_FORMAT="${COMPRESS_FORMAT:-zip}"       # zip/tar.gz/7z
COMPRESS_LEVEL="${COMPRESS_LEVEL:-6}"           # Nivel compresión 1-9
GIT_AUTO="${GIT_AUTO:-true}"
DOCKER_AUTO="${DOCKER_AUTO:-false}"
DOCKER_IMAGE="${DOCKER_IMAGE:-ubuntu:latest}"
DOCKER_WORKSPACE="/workspace"
COMPILE_AUTO="${COMPILE_AUTO:-false}"
COMPILE_CMD="${COMPILE_CMD:-make}"
FOTOMATON_AUTO="${FOTOMATON_AUTO:-true}"

# === Sistema Fotomatón ===
take_snapshot() {
    local snapshot_name="$1"
    local target_dir="$2"
    if [[ -d "$target_dir" ]]; then
        find "$target_dir" -type f -exec stat -c "%n|%s|%Y" {} \; | sort > ".snapshot_${snapshot_name}" 2>/dev/null
        echo "📸 Snapshot $snapshot_name tomado"
    fi
}

clean_metadata() {
    local target_dir="$1"
    if [[ "$FOTOMATON_AUTO" == "true" && -d "$target_dir" ]]; then
        echo "🧹 Limpiando metadata innecesaria..."
        find "$target_dir" -name ".DS_Store" -delete 2>/dev/null
        find "$target_dir" -name "*.tmp" -delete 2>/dev/null
        find "$target_dir" -name "__pycache__" -type d -exec rm -rf {} \; 2>/dev/null
        find "$target_dir" -name "node_modules/.cache" -type d -exec rm -rf {} \; 2>/dev/null
        find "$target_dir" -name ".docker_temp*" -delete 2>/dev/null
        echo "✅ Metadata limpiada"
    fi
}

# === Lógica de compresión ===
case "$COMPRESS_FORMAT" in
    "zip") COMPRESS_EXT="zip"; COMPRESS_CMD="zip -${COMPRESS_LEVEL}rq"; UNCOMPRESS_CMD="unzip -q" ;;
    "tar.gz") COMPRESS_EXT="tar.gz"; COMPRESS_CMD="tar -czf"; UNCOMPRESS_CMD="tar -xzf" ;;
    "7z") COMPRESS_EXT="7z"; COMPRESS_CMD="7z a -mx=$COMPRESS_LEVEL"; UNCOMPRESS_CMD="7z x" ;;
esac
COMPRESS_FILE="${COMPRESS_TARGET}.${COMPRESS_EXT}"

# === Snapshots y descompresión ===
take_snapshot "original" "."
if [[ -f "$COMPRESS_FILE" && ! -d "$COMPRESS_TARGET" ]]; then
    echo "🌸 Desplegando $COMPRESS_TARGET..."
    $UNCOMPRESS_CMD "$COMPRESS_FILE" >/dev/null 2>&1 && COMPRESS_CLEANUP=true
    take_snapshot "clean" "$COMPRESS_TARGET"
fi

# === Git automático ===
if [[ "${COMPRESS_CLEANUP:-false}" == "true" && "$GIT_AUTO" == "true" && -d "$COMPRESS_TARGET" ]]; then
    cd "$COMPRESS_TARGET"
    if [[ ! -d ".git" ]]; then
        git init >/dev/null 2>&1
        git add . >/dev/null 2>&1
        git commit -m "📦 Auto-commit: Estado inicial descomprimido $(date)" >/dev/null 2>&1
    else
        git add . >/dev/null 2>&1
        git commit -m "📦 Auto-commit: Estado antes de trabajar $(date)" >/dev/null 2>&1
    fi
    cd - >/dev/null
    take_snapshot "with_git" "$COMPRESS_TARGET"
fi

# === Docker automático ===
if [[ "$DOCKER_AUTO" == "true" && "${COMPRESS_CLEANUP:-false}" == "true" && -d "$COMPRESS_TARGET" ]]; then
    if command -v docker >/dev/null 2>&1; then
        CONTAINER_NAME="origami_$(basename "$0" .sh)_$$"
        FULL_TARGET_PATH="$(pwd)/$COMPRESS_TARGET"
        docker run -d \
            --name "$CONTAINER_NAME" \
            --mount "type=bind,source=$FULL_TARGET_PATH,target=$DOCKER_WORKSPACE" \
            --workdir "$DOCKER_WORKSPACE" \
            "$DOCKER_IMAGE" \
            tail -f /dev/null >/dev/null 2>&1 && DOCKER_CLEANUP=true
        docker_exec() { docker exec "$CONTAINER_NAME" "$@"; }
        export -f docker_exec 2>/dev/null || true
        take_snapshot "with_docker" "$COMPRESS_TARGET"
    else
        echo "⚠️ Docker no disponible, ejecutando en host"
        DOCKER_AUTO="false"
    fi
fi

# === Ejemplo de uso ===
if [[ "$DOCKER_AUTO" == "true" ]]; then
    echo "🐋 Ejecutando comandos en container Docker..."
    docker_exec ls -la
    docker_exec echo "Hello from Docker!" > test_docker.txt
    docker_exec cat test_docker.txt
else
    echo "🖥️ Ejecutando comandos en host..."
    ls -la "$COMPRESS_TARGET"
    echo "Hello from Host!" > "$COMPRESS_TARGET/test_host.txt"
    cat "$COMPRESS_TARGET/test_host.txt"
fi

# === Snapshots finales y limpieza ===
[[ -d "$COMPRESS_TARGET" ]] && take_snapshot "after_work" "$COMPRESS_TARGET"
clean_metadata "$COMPRESS_TARGET"

# === Compilación opcional ===
if [[ "$COMPILE_AUTO" == "true" && -d "$COMPRESS_TARGET" ]]; then
    cd "$COMPRESS_TARGET"
    $COMPILE_CMD || echo "⚠️ Error en compilación"
    cd - >/dev/null
    take_snapshot "compiled" "$COMPRESS_TARGET"
fi

# === Comprimir y limpiar ===
case "$COMPRESS_FORMAT" in
    "zip") $COMPRESS_CMD "$COMPRESS_FILE" "$COMPRESS_TARGET" >/dev/null 2>&1 ;;
    "tar.gz") $COMPRESS_CMD "$COMPRESS_FILE" "$COMPRESS_TARGET" >/dev/null 2>&1 ;;
    "7z") $COMPRESS_CMD "$COMPRESS_FILE" "$COMPRESS_TARGET"/* >/dev/null 2>&1 ;;
esac

if [[ $? -eq 0 && -f "$COMPRESS_FILE" ]]; then
    rm -rf "$COMPRESS_TARGET"
    echo "✅ $COMPRESS_TARGET guardado en $COMPRESS_FILE"
    rm -f .snapshot_* 2>/dev/null
else
    echo "⚠️ Error comprimiendo, manteniendo carpeta"
fi
