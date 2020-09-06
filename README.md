# dotfiles

My dotfiles

## Setup

```shell
git clone https://github.com/candy12t/dotfiles.git
cd dotfiles
./setup.sh
# Homebrew
cd brew
./setup_brew.sh
```

## Backup Homebrew

```shell
cd brew
./backup_brew.sh
```

## Mac設定

スクリーンショット影なし

```shell
defaults write com.apple.screencapture disable-shadow -boolean true
killall SystemUIServer
```

Finderドットファイル表示

```shell
defaults write com.apple.finder AppleShowAllFiles TRUE
killall Finder
```
