# History configuration
export HISTFILE="$HOME/.config/zsh/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if ! command -v devbox &> /dev/null; then
  curl -fsSL https://get.jetify.com/devbox | bash
fi

if [[ -z $GPG_TTY ]] && tty &>/dev/null; then
  export GPG_TTY=$(tty)
fi