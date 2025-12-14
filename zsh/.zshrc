export ZDOTDIR="$HOME/.config/zsh"

# ---------- modules ----------
for f in env zinit completion plugins completions-lazy fzf alias; do
  source "$ZDOTDIR/$f.zsh"
done

# ---------- prompt ----------
eval "$(starship init zsh)"
