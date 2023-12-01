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

## SSH接続しているリモートマシンにおいてtmuxからクリップボードへのコピーの設定

- リモートマシン
    - `xsel`のインストール
    - `/etc/ssh/sshd_config`に`X11Forwarding yes`を追記し、X11フォワーディングを許可し、sshdを再起動
- ローカルマシン
    - XQuartzの起動
        - `xeyes`や`xclock`を実行し、正しく動作しているか確認できる
    - SSHでのX11フォワーディングを以下のどちらかの方法で行う
        - ~/.ssh/configに`ForwardX11 yes`を追加
        - -XオプションをつけてSSH接続
- SSH接続後、`echo $DISPLAY`でDISPLAY環境変数が設定されていること確認(例: `localhost:10.0`)
