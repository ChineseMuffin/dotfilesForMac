# dotfiles for Mac
macOSを初期設定するためのリポジトリです。

参考にしたリポジトリ https://github.com/webpro/dotfiles/tree/main

## 使い方

### Apple Diagnosticsを実行

https://support.apple.com/ja-jp/102550

### Xcode Command Line Toolsのインストール
(git makeを含む)
```
git --version
```

### リポジトリのクローン
```
bash -c "`curl -fsSL https://raw.githubusercontent.com/ChineseMuffin/dotfilesForMac/refs/heads/main/remote-install.sh`"

cd ~/.dotfiles
make

# cleanup
cd
rm -rf .dotfiles
```

## App Store
### Mac (mas経由インストール)
- RunCat
- Xcode
- Bitwarden
- OneDrive
- Office
    - Excel
    - Word
    - PowerPoint

### iPhone (手動インストール)
- 280blocker

## Homebrew
### Formulae
- zsh-completions
- mas
- gh
- python
- node

### Casks
- gimp
- google-chrome
- google-japanese-ime
- iterm2
- keyboard-cleaner
- visual-studio-code
- zoom

## Visual Studio Code
- Git Graph
    - mhutchie.git-graph
- Python
    - ms-python.python

## 直接インストール
- CLIP STUDIO
- ワコムタブレットユーティリティ
    - CTL-6100WL
- Docker

## 初期設定
- Dockの設定
    - Dockを自動的に非表示
    - サイズ調整
    - Dockの情報取得
        - `defaults read com.apple.dock`
- キーボード設定
    - Google
    - ロシア語
- Git
    - user.name
    - user.email
        - GitHub用の公開アドレス
            - https://github.com/settings/emails
    - gpg.format=ssh
    - user.signingkey=SSHパブリックキーのパス
    - commit.gpgsign=true
- GitHub private keyを登録
    - `gh ssh-key add`

## ターミナル
- Icebergをインポート
- .zshrc移植
