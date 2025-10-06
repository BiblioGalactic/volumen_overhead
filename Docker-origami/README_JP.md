Docker-Origami + Git + コンパイル + フォトブース

説明

プロジェクト管理用の公開かつモジュール化されたテンプレートで、以下の機能があります：
	•	スナップショットとメタデータのクリーニング（フォトブース）
	•	Git 自動バージョン管理
	•	Docker 統合による隔離環境
	•	任意のプロジェクトコンパイル
	•	作業ディレクトリの圧縮と保存

再現可能な開発環境やワークフロー自動化に最適です。

⸻

システム要件
	•	Bash 5 以上
	•	Docker（任意、DOCKER_AUTO を使用する場合のみ）
	•	Git がインストールされていること
	•	圧縮ツール（zip、tar、7z、COMPRESS_FORMAT による）
	•	Make、cargo、go、npm または Python（COMPILE_AUTO が有効な場合、COMPILE_CMD に依存）

⸻

ステップバイステップの使用方法

1. 初期設定

スクリプト実行前にこれらの変数を調整するか、環境変数としてエクスポートできます：

export COMPRESS_TARGET="data"           # 管理するフォルダ
export COMPRESS_FORMAT="zip"            # zip/tar.gz/7z
export COMPRESS_LEVEL="6"               # 圧縮レベル 1-9
export GIT_AUTO="true"                  # 自動 Git を有効化
export DOCKER_AUTO="false"              # 自動 Docker を有効化
export DOCKER_IMAGE="ubuntu:latest"     # 使用する Docker イメージ
export DOCKER_WORKSPACE="/workspace"    # コンテナ内ディレクトリ
export COMPILE_AUTO="false"             # 自動コンパイルを有効化
export COMPILE_CMD="make"               # コンパイルコマンド
export FOTOMATON_AUTO="true"            # メタデータを自動クリーニング

2. 基本的な実行

./docker_origami.sh

スクリプトは以下を実行します：
	•	フォルダの初期スナップショット作成
	•	既存の圧縮ファイルを解凍
	•	Git リポジトリの初期化または更新
	•	DOCKER_AUTO が有効な場合、Docker コンテナを起動
	•	コンテナまたはホスト内でサンプルコマンドを実行
	•	不要なメタデータをクリーニング
	•	COMPILE_AUTO が有効な場合、プロジェクトをコンパイル
	•	フォルダを圧縮し最終的にクリーンアップ

3. コマンド例

自動 Git
	•	存在しない場合、Git 履歴を作成
	•	作業前後に自動コミット

Docker

docker_exec ls -la
docker_exec echo "Hello from Docker!" > test_docker.txt
docker_exec cat test_docker.txt

ホスト

ls -la "$COMPRESS_TARGET"
echo "Hello from Host!" > "$COMPRESS_TARGET/test_host.txt"
cat "$COMPRESS_TARGET/test_host.txt"

任意のコンパイル

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

4. 最終クリーンアップとスナップショット
	•	フォルダの最終スナップショット
	•	メタデータ自動クリーニング
	•	フォルダを圧縮し、保存や配布の準備

⸻

注意事項
	•	複数の圧縮形式に対応：zip、tar.gz、7z
	•	Docker やコンパイルなしでも部分的に実行可能
	•	モジュール化：ユーザーコマンドブロックはワークフローに合わせて変更可能
	•	オープンソース：自由にカスタマイズして共有可能

⸻

**Eto Demerzel** (Gustavo Silva Da Costa)
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
