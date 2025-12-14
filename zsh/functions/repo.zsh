# Navigate to a local repository root using ghq and fzf
function repo() {
  local repo_path=$(ghq list | fzf --prompt="Select repository: " --height=40% --reverse)
  if [ -n "$repo_path" ]; then
    cd "$(ghq root)/$repo_path"
  fi
}
