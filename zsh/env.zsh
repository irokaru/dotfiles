# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if ! command -v devbox &> /dev/null; then
  curl -fsSL https://get.jetify.com/devbox | bash
fi

if [[ -z $GPG_TTY ]] && tty &>/dev/null; then
  export GPG_TTY=$(tty)
fi