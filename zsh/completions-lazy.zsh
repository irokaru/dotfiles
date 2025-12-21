local -a completion_cmds=(
  'gh completion -s zsh'
  'devbox completion zsh'
  'k9s completion zsh'
)

for cmd in "${completion_cmds[@]}"; do
  zinit ice wait lucid atload"eval \"\$($cmd)\""
  zinit light zdharma-continuum/null
done

if type brew &>/dev/null; then
  zinit ice wait lucid as"completion"
  zinit snippet "$(brew --prefix)/share/zsh/site-functions/_ghq"
fi
