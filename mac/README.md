# Mac Setting

## Homebrew

### Setup Homebrew

```shell
cd brew
./setup_brew.sh
```

### Backup Homebrew

```shell
cd brew
./backup_brew.sh
```

## App

### スクリーンショット影なし

```shell
defaults write com.apple.screencapture disable-shadow -boolean true
killall SystemUIServer
```

### Finderドットファイル表示

```shell
defaults write com.apple.finder AppleShowAllFiles TRUE
killall Finder
```
