# ---------- functions ----------
# Load all function files from functions/ directory
if [ -d "$ZDOTDIR/functions" ]; then
  for f in "$ZDOTDIR/functions"/*.zsh; do
    [ -f "$f" ] && source "$f"
  done
fi
