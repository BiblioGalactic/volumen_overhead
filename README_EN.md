
Docker-Origami + Git + Compile + Photobooth

Description

Public, modular template for managing projects with:
	•	Snapshots and metadata cleanup (Photobooth)
	•	Automatic version control with Git
	•	Docker integration for isolated environments
	•	Optional project compilation
	•	Compression and storage of working folders

Ideal for reproducible development environments and workflow automation.

⸻

Requirements
	•	Bash 5 or higher
	•	Docker (optional, only if you want to use DOCKER_AUTO)
	•	Git installed
	•	Compression tools (zip, tar, 7z depending on COMPRESS_FORMAT)
	•	Make, cargo, go, npm, or python (depending on COMPILE_CMD if COMPILE_AUTO is enabled)

⸻

Step-by-step Usage

1. Initial Configuration

You can adjust these variables before running the script or export them as environment variables:

export COMPRESS_TARGET="data"           # Folder to manage
export COMPRESS_FORMAT="zip"            # zip/tar.gz/7z
export COMPRESS_LEVEL="6"               # Compression level 1-9
export GIT_AUTO="true"                  # Enable automatic git
export DOCKER_AUTO="false"              # Enable Docker automation
export DOCKER_IMAGE="ubuntu:latest"     # Docker image to use
export DOCKER_WORKSPACE="/workspace"    # Directory inside the container
export COMPILE_AUTO="false"             # Enable automatic compilation
export COMPILE_CMD="make"               # Compilation command
export FOTOMATON_AUTO="true"            # Automatically clean metadata


⸻

2. Basic Execution

./docker_origami.sh

The script will:
	•	Take an initial snapshot of the folder
	•	Decompress if a compressed file exists
	•	Initialize or update a Git repository
	•	Start a Docker container if DOCKER_AUTO is active
	•	Run example commands inside the container or on the host
	•	Clean unnecessary metadata
	•	Compile the project if COMPILE_AUTO is enabled
	•	Compress and clean the final folder

⸻

3. Example Commands

Automatic Git
	•	Creates Git history if none exists
	•	Automatic commits before and after work

Docker Example

docker_exec ls -la
docker_exec echo "Hello from Docker!" > test_docker.txt
docker_exec cat test_docker.txt

Host Example

ls -la "$COMPRESS_TARGET"
echo "Hello from Host!" > "$COMPRESS_TARGET/test_host.txt"
cat "$COMPRESS_TARGET/test_host.txt"

Optional Compilation

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

4. Final Cleanup & Snapshots
	•	Final folder snapshots
	•	Metadata cleaned automatically
	•	Folder compressed and ready for storage or distribution

⸻

Notes
	•	Compatible with multiple compression formats: zip, tar.gz, 7z
	•	Can run partially without Docker or compilation
	•	Modular: you can customize the user command block as needed
	•	Open-source: adapt and share your workflow

⸻

Author: Gustavo Silva da Costa
Suggested Repository: Bibliogalactic


