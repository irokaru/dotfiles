# dotfiles for WSL2

個人の zsh/starship 設定ファイル集です。

## Features

- **zsh** - インタラクティブシェルの設定
  - zinit によるプラグイン管理
  - lazy loading による起動速度の最適化
  - gh, ghq などのコマンド補完

- **starship** - クロスプラットフォームのモダンシェルプロンプト

- **Homebrew** - macOS/Linux のパッケージ管理

- **Git** - git 設定ファイル管理

## Installation

```bash
# 1. リポジトリのクローン
git clone https://github.com/irokaru/dotfiles.git
cd dotfiles

# 2. インストールスクリプトを実行
./install.sh

# 3. シェルを再起動
exec zsh
```

詳細は [install.sh](install.sh) を参照してください。

## File Structure

```
dotfiles/
├── Brewfile                  # Homebrew パッケージ定義
├── gitconfig                 # Git 設定
├── install.sh                # インストールスクリプト
├── README.md                 # このファイル
├── AGENTS.md                 # AIエージェント向けドキュメント
├── scripts/
│   └── brew_dump.sh          # Brewfile 更新スクリプト
├── starship/
│   └── starship.toml         # starship プロンプト設定
└── zsh/
    ├── .zshrc                # zsh メイン設定
    ├── env.zsh               # 環境変数
    ├── zinit.zsh             # zinit の初期化
    ├── plugins.zsh           # プラグイン管理
    ├── completion.zsh        # 基本補完設定
    ├── completions-lazy.zsh  # 遅延補完読み込み
    ├── fzf.zsh               # fzf キーバインド
    └── alias.zsh             # エイリアス設定
```

## Requirements

- zsh 5.0+
- Homebrew

## License

MIT
