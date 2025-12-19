Docker-Origami + Git + 编译 + 照片亭

描述

一个公共且模块化的模板，用于管理项目，功能包括：
	•	快照和元数据清理（照片亭）
	•	Git 自动版本控制
	•	Docker 集成，实现隔离环境
	•	可选的项目编译
	•	工作目录压缩和存储

非常适合可复现的开发环境和工作流自动化。

⸻

系统要求
	•	Bash 5 或更高版本
	•	Docker（可选，仅在启用 DOCKER_AUTO 时需要）
	•	已安装 Git
	•	压缩工具（zip、tar、7z，根据 COMPRESS_FORMAT）
	•	Make、cargo、go、npm 或 Python（根据 COMPILE_CMD，如果启用 COMPILE_AUTO）

⸻

分步使用说明

1. 初始配置

在运行脚本之前，你可以调整这些变量，或者导出为环境变量：

export COMPRESS_TARGET="data"           # 要管理的文件夹
export COMPRESS_FORMAT="zip"            # zip/tar.gz/7z
export COMPRESS_LEVEL="6"               # 压缩等级 1-9
export GIT_AUTO="true"                  # 启用自动 Git
export DOCKER_AUTO="false"              # 启用自动 Docker
export DOCKER_IMAGE="ubuntu:latest"     # 使用的 Docker 镜像
export DOCKER_WORKSPACE="/workspace"    # 容器内的目录
export COMPILE_AUTO="false"             # 启用自动编译
export COMPILE_CMD="make"               # 编译命令
export FOTOMATON_AUTO="true"            # 自动清理元数据

2. 基本执行

./docker_origami.sh

脚本将执行以下操作：
	•	对文件夹进行初始快照
	•	解压任何已有的压缩包
	•	初始化或更新 Git 仓库
	•	如果启用 DOCKER_AUTO，启动 Docker 容器
	•	在容器或主机中运行示例命令
	•	清理不必要的元数据
	•	如果启用 COMPILE_AUTO，编译项目
	•	压缩并清理最终文件夹

3. 示例命令

自动 Git
	•	如果不存在，则创建 Git 历史
	•	自动提交工作前后

Docker

docker_exec ls -la
docker_exec echo "Hello from Docker!" > test_docker.txt
docker_exec cat test_docker.txt

主机

ls -la "$COMPRESS_TARGET"
echo "Hello from Host!" > "$COMPRESS_TARGET/test_host.txt"
cat "$COMPRESS_TARGET/test_host.txt"

可选编译

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

4. 最终清理与快照
	•	文件夹最终快照
	•	自动清理元数据
	•	文件夹压缩，准备存储或分发

⸻

注意事项
	•	支持多种压缩格式：zip、tar.gz、7z
	•	可在没有 Docker 或编译的情况下部分运行
	•	模块化：可根据工作流程修改用户命令块
	•	开源：自由调整并共享你的工作流

⸻

**Eto Demerzel** (Gustavo Silva Da Costa)
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
