#!/usr/bin/env bash
set -e

CURRENT_DIR="$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd
)"

DIRS=("${HOME}/.config" "${HOME}/.gnupg")
LINKS=(
  # zsh
  "${CURRENT_DIR}/zsh/.zshrc:${HOME}/.zshrc"
  "${CURRENT_DIR}/zsh:${HOME}/.config/zsh"
  # starship
  "${CURRENT_DIR}/starship/starship.toml:${HOME}/.config/starship.toml"
  # git
  "${CURRENT_DIR}/git:${HOME}/.config/git"
  # gpg-agent
  "${CURRENT_DIR}/gpg-agent/gpg-agent-conf:${HOME}/.gnupg/gpg-agent-conf"
  # mise
  "${CURRENT_DIR}/mise:${HOME}/.config/mise"
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

# Install Podman (https://podman.io/docs/installation)
if ! command -v podman >/dev/null; then
  echo "Installing Podman..."

  # Remove any conflicting packages
  for pkg in podman-docker; do 
    sudo apt remove -y $pkg 2>/dev/null || true
  done

  # Install Podman and dependencies
  sudo apt update
  sudo apt install -y podman podman-compose crun slirp4netns fuse-overlayfs

  # Setup rootless Podman
  sudo usermod --add-subuids 10000-75535 $USER
  sudo usermod --add-subgids 10000-75535 $USER

  # Enable systemd socket for Podman (may require re-login)
  systemctl --user enable podman.socket 2>/dev/null || echo "Note: systemd user session not available. Please run 'systemctl --user enable podman.socket' after login."
  systemctl --user start podman.socket 2>/dev/null || true
  loginctl enable-linger $USER 2>/dev/null || true

  echo "Podman installed successfully. You may need to log out and back in for the configuration to take effect."
else
  echo "Podman is already installed."
fi

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
