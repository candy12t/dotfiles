# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 概要

nix-darwin と home-manager を使った macOS 向けの Nix Flake ベースのdotfilesリポジトリ。

## よく使うコマンド

### 設定の適用

```bash
# 設定をシステムに適用する（通常の運用）
darwin-rebuild switch --flake .#MacBookAir

# 適用せずにビルドのみ行う（検証用）
darwin-rebuild build --flake .#MacBookAir

# nix-darwin 未インストール時の初回セットアップ
nix run nix-darwin -- switch --flake .#MacBookAir
```

### Flake の更新

```bash
# すべての flake inputs を更新（flake.lock を更新）
nix flake update

# 特定の input のみ更新（例: llm-agents）
nix flake update llm-agents
```

## アーキテクチャ

### ディレクトリ構成

- **`flake.nix`** — エントリーポイント。`mkDarwinSystem` ヘルパー関数で `hosts/` 以下の各ホスト設定から `darwinConfigurations` を生成する。modules は `./darwin` と `./profiles/<profile>` の2つだけで、配線は各モジュール側で行う。主要 flake inputs:
  - `llm-agents` — `claude-code` をシステムパッケージとして提供
  - `nix-index-database` — `comma`（`, <cmd>` で任意の nix パッケージを一時実行できる）を提供
- **`hosts/`** — ホストごとの設定ファイル（username、system、homeDir、profile を定義）。`hosts/default.nix` の attr 名が構成名になる（`.#MacBookAir` = 個人、`.#work` = 会社 Mac）。新しいマシンを追加する場合はファイルを追加し、`hosts/default.nix` に追記する。
- **`profiles/<profile>/`** — `personal` / `work` プロファイル固有の設定。`darwin.nix`（nix-darwin モジュール）と `home.nix`（home-manager モジュール）を置き、`default.nix` が両者を配線する（`home.nix` は `home-manager.users.<username>.imports` に追加）。host の `profile` に応じて flake が import する。リスト型オプション（casks、packages など）は共通設定にマージされる。work プロファイルで信頼させる CA 証明書（Cato Networks）も `profiles/work/` に置く。
- **`examples/`** — git 管理しないローカル設定（`~/.zshrc.local`、`~/.config/git/local.gitconfig`）のテンプレート。**会社名・org 名・社内用の値などはリポジトリ（public）に書かず、これらのローカルファイルに置く。**
- **`darwin/`** — nix-darwin モジュール。関心ごとにファイルを分け、`default.nix` が imports する（`users.nix`、`system-defaults.nix`、`nix.nix`、`security.nix`、`homebrew.nix`、`home-manager.nix`、`llm-agents.nix`）。
- **`home/`** — home-manager モジュール。`packages.nix` がユーザーパッケージ一覧、`theme.nix` が各ツールで共有する tokyonight（`tokyonightSrc`）、`<tool>.nix` が各ツールの設定。
- **`config/`** — 実際の設定ファイル。`config/nvim/` と `config/efm-langserver/` は home-manager から `mkOutOfStoreSymlink` でシンボリックリンクされるため、**変更がリビルドなしで即反映される**。`config/iterm/` と `config/claude/` は手動管理（シンボリックリンク不使用）。

### 設定の分担

| 変更したいもの | 編集するファイル |
|---|---|
| macOS システム設定（Dock、Finder、キーボードなど） | `darwin/system-defaults.nix` |
| Nix の設定（substituters など） | `darwin/nix.nix` |
| Homebrew casks（共通） | `darwin/homebrew.nix` |
| システムパッケージ（claude-code） | `darwin/llm-agents.nix` |
| プロファイル固有の casks・システム設定 | `profiles/<profile>/darwin.nix` |
| プロファイル固有のパッケージ・git・zsh 設定 | `profiles/<profile>/home.nix` |
| 公開したくないマシン固有の設定 | `~/.zshrc.local`、`~/.config/git/local.gitconfig`（`examples/` 参照） |
| ユーザー情報（username, homeDir, profile） | `hosts/<name>.nix` |
| ユーザーパッケージ（CLI ツールなど） | `home/packages.nix` |
| シェル・ツール設定（zsh、tmux など） | `home/<tool>.nix` |
| Neovim / efm-langserver の設定 | `config/nvim/`、`config/efm-langserver/` |
| 新しいツールモジュール追加 | `home/<tool>.nix` を作成し `home/default.nix` の `imports` に追記 |

### Neovim 設定の扱い

`home/nvim.nix` は Neovim 本体と LSP/formatter をインストールするだけで、実際の設定は `config/nvim/` をシンボリックリンクしている。そのため `config/nvim/` 内の変更は `darwin-rebuild switch` 不要で即時反映される。

### Lua フォーマッター

`stylua.toml` がリポジトリルートにある。Neovim の Lua 設定を編集する際は stylua の設定に従うこと。

### Nix メンテナンス

```bash
# 古い世代を削除してストアを整理
nix-collect-garbage -d

# システム全体のプロファイルも含めて GC
sudo nix-collect-garbage -d
```
