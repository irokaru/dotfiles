#!/usr/bin/env bash
set -e

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)"

# install
sudo apt update && sudo apt install -y \
  build-essential \
  curl \
  file \
  git \
  procps \
  ca-certificates && \
  sudo apt autoremove -y

# Create symbolic links for configuration files
mkdir -p ~/.config
mkdir -p ~/.config/git
ln -sfnT "${CURRENT_DIR}/zsh" ~/.config/zsh
ln -sfnT "${CURRENT_DIR}/zsh/.zshrc" ~/.zshrc
ln -sfnT "${CURRENT_DIR}/starship/starship.toml" ~/.config/starship.toml
ln -sfnT "${CURRENT_DIR}/gitconfig" ~/.config/git/config

# Install Homebrew and dependencies from Brewfile
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew bundle --file "$CURRENT_DIR/Brewfile"
