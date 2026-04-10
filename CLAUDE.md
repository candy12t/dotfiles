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

- **`flake.nix`** — エントリーポイント。`mkDarwinSystem` ヘルパー関数で `hosts/` 以下の各ホスト設定から `darwinConfigurations` を生成する。
- **`hosts/`** — ホストごとの設定ファイル（hostname、username、system、homeDir を定義）。新しいマシンを追加する場合はここにファイルを追加し、`flake.nix` の `hosts` リストに追記する。
- **`darwin/`** — nix-darwin モジュール。macOS システム設定（Dock、Finder、トラックパッドなど）と Homebrew の cask 管理を行う。
- **`home/`** — home-manager モジュール。ユーザーレベルのパッケージと各ツールの設定を管理する。
- **`config/`** — 実際の設定ファイル（nvim、efm-langserver、iterm、claude）。home-manager から `mkOutOfStoreSymlink` でシンボリックリンクされるため、**変更がリビルドなしで即反映される**。

### 設定の分担

| 変更したいもの | 編集するファイル |
|---|---|
| macOS システム設定 | `darwin/system.nix` |
| Homebrew casks | `darwin/system.nix` |
| ユーザーパッケージ（CLI ツールなど） | `home/default.nix` |
| シェル・ツール設定（zsh、tmux など） | `home/<tool>.nix` |
| Neovim / efm-langserver の設定 | `config/nvim/`、`config/efm-langserver/` |

### Neovim 設定の扱い

`home/nvim.nix` は Neovim 本体と LSP/formatter をインストールするだけで、実際の設定は `config/nvim/` をシンボリックリンクしている。そのため `config/nvim/` 内の変更は `darwin-rebuild switch` 不要で即時反映される。

### Lua フォーマッター

`stylua.toml` がリポジトリルートにある。Neovim の Lua 設定を編集する際は stylua の設定に従うこと。
