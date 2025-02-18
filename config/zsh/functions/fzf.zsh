fzf_ghq() {
  local repository fullpath_repository
  repository=$(ghq list | fzf) &&
  fullpath_repository=$(ghq list --full-path --exact "${repository}") &&
  cd "${fullpath_repository}"
}

fzf_rg_file() {
  [ $(pwd) = $HOME ] && echo "current directory is HOME. change any directory" >&2 && return
  local files="$(rg --files --hidden --follow --glob '!.git' | fzf -m --preview 'bat --color=always {}')"
  [ -n "$files" ] && echo "$files" | xargs $EDITOR
}

fzf_rg() {
  [ $(pwd) = $HOME ] && echo "current directory is HOME. change any directory" >&2 && return
  local files="$(rg -n '' | fzf -m --delimiter : --preview 'bat --color=always --highlight-line {2} {1}' --preview-window '+{2}+3/3' | awk -F: '{print $1}')"
  [ -n "$files" ] && echo "$files" | xargs $EDITOR
}

alias "fq"='fzf_ghq'
alias "ff"='fzf_rg_file'
alias "fr"='fzf_rg'
