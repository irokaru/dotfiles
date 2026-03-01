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

# Install Docker Engine (https://docs.docker.com/engine/install/ubuntu/)
if ! command -v docker >/dev/null; then
  echo "Installing Docker Engine..."

  # Remove old versions
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do 
    sudo apt remove -y $pkg 2>/dev/null || true
  done

  # Add Docker's official GPG key
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update

  # Install Docker Engine
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Add user to docker group
  sudo usermod -aG docker $USER

  echo "Docker installed successfully. You may need to log out and back in for group changes to take effect."
else
  echo "Docker is already installed."
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
