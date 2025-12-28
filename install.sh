#!/usr/bin/env bash
set -e

CURRENT_DIR="$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd
)"

DIRS=("${HOME}/.config")
LINKS=(
  # zsh
  "${CURRENT_DIR}/zsh/.zshrc:${HOME}/.zshrc"
  "${CURRENT_DIR}/zsh:${HOME}/.config/zsh"
  # starship
  "${CURRENT_DIR}/starship/starship.toml:${HOME}/.config/starship.toml"
  # git
  "${CURRENT_DIR}/git:${HOME}/.config/git"
  # nvim
  "${CURRENT_DIR}/nvim:${HOME}/.config/nvim"
)

# install
sudo apt update && sudo apt install -y \
  build-essential \
  curl \
  file \
  git \
  procps \
  ca-certificates &&
  sudo apt autoremove -y

# Create dirs
for dir in ${DIRS[@]}; do
  mkdir -p "$dir"
done

# Create symbolic links for configuration files
for link in "${LINKS[@]}"; do
  ln -sfnT "${link%:*}" "${link#*:}"
done

# Install Homebrew and dependencies from Brewfile
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew bundle --file "$CURRENT_DIR/Brewfile"
