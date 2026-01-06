# dotfiles for Mac
macOSを初期設定するためのリポジトリです。

参考にしたリポジトリ https://github.com/webpro/dotfiles/tree/main

## 使い方
### Xcode Command Line Toolsのインストール
(git makeを含む)
```
sudo softwareupdate -i -a
xcode-select --install
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
- 280blocker
- RunCat
- Xcode
- Bitwarden
- Office
    - Excel
    - Word
    - PowerPoint

## Homebrew
### Formulae
- git
- python

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
- Docker
- OneDrive

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
    - name
    - mail
    - GitHub private key
