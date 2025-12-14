zinit ice wait lucid atload'eval "$(gh completion -s zsh)"'
zinit light zdharma-continuum/null

if type brew &>/dev/null; then
  zinit ice wait lucid as"completion"
  zinit snippet "$(brew --prefix)/share/zsh/site-functions/_ghq"
fi
