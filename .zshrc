if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -U compinit
compinit -u

if [ "$(uname -s)" = 'Darwin' ] && [ "$(uname -m)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="/opt/homebrew/bin:$PATH"
fi

alias ls='ls -F --color'
alias la='ls -A'
alias ll='ls -Al'
alias g='git'
alias t='tmux'
alias :q='exit'
alias gd='cd "$(git rev-parse --show-toplevel)"'


# python
if [ -e "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi

# go
if [ -e "$HOME/.goenv" ]; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
  export PATH="$GOROOT/bin:$PATH"
  export GOENV_DISABLE_GOPATH=1
  export GOPATH=$HOME/go
  export GO111MODULE=on
  export PATH="$PATH:$GOPATH/bin"
fi

# ruby
if [ -e "$HOME/.rbenv" ]; then
  export RBENV_ROOT="$HOME/.rbenv"
  export PATH="$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init -)"
fi

# node
if [ -e "$HOME/.nodenv" ]; then
  export NODENV_ROOT="$HOME/.nodenv"
  export PATH="$NODENV_ROOT/bin:$PATH"
  eval "$(nodenv init -)"
fi

# volta
if [ -e "$HOME/.volta" ]; then
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
fi

# jdk
if [ -d "/usr/local/jdk" ]; then
  export JAVA_HOME="/usr/local/jdk"
  export PATH="$JAVA_HOME/bin:$PATH"
fi

# rust
# how to install rustup (ref: "https://www.rust-lang.org/tools/install")
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
if [ -e "$HOME/.cargo" ]; then
  export CARGO_ROOT="$HOME/.cargo"
  source "$HOME/.cargo/env"
fi

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 60% --border horizontal --reverse --preview "bat --color=always --style=grid -r :15 {}"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# starship
if [ -x "$(which starship)" ]; then
  eval "$(starship init zsh)"
  export STARSHIP_CONFIG="$HOME/.starship/config.toml"
fi

# direnv
if [ -x "$(which direnv)" ]; then
  eval "$(direnv hook zsh)"
fi

# gcloud
if [ -d "/usr/local/Caskroom/google-cloud-sdk" ]; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
fi

# bookmark
# ref: https://threkk.medium.com/how-to-use-bookmarks-in-bash-zsh-6b8074e40774
if [ -d "$HOME/.bookmarks" ]; then
  export CDPATH=".:$HOME/.bookmarks:/"
  alias goto="cd -P"
fi

if [ -e "$HOME/local" ]; then
  export PATH="$HOME/local/bin:$PATH"
fi

[ -e "/usr/local/opt/mysql-client" ] && export PATH="/usr/local/opt/mysql-client/bin:$PATH"

fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
    fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m --preview="echo {} | sed 's/.* //' | xargs git log --oneline --color=always") &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fa() {
  local adds selected_adds
  if [[ -x "$(which unbuffer)" ]]; then
    adds=$(unbuffer git status -s -uall)
  else
    adds=$(git status -s -uall)
  fi
  selected_adds=$(echo "$adds" |
    fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" |
    awk '{print $2}' |
    tr '\n' ' ' |
    sed "s/ $//")
  if [[ -n "${selected_adds}" ]]; then
    git add $(echo "$selected_adds") &&
    echo "added '$selected_adds'"
  fi
}

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%an(%ae) %cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort --preview "echo {} | awk '{print \$2}' | xargs git log -1 -p --color=always" \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

fgt() {
  local bookmarks bookmark
  bookmarks=$(ls ~/.bookmarks | sed "s/@$//") &&
  bookmark=$(echo "${bookmarks}" | fzf --ansi +m --preview "") &&
  cd -P "${bookmark}"
}

fq() {
  local repository fullpath_repository
  repository=$(ghq list | fzf +m --preview "") &&
  fullpath_repository=$(ghq list --full-path --exact "${repository}") &&
  cd "${fullpath_repository}"
}

gmi() {
  local dir=${1:-$(pwd | tr '/' ' ' | awk '{ print $NF }')}
  go mod init github.com/candy12t/"${dir}"
}

gtc() {
  go test $1 -coverprofile=cover.out
  go tool cover -html=cover.out
  rm -rf cover.out
}

ssh_change_profile() {
  case $1 in
    production-* | prod-* ) echo -e "\033]1337;SetProfile=production\a" ;;
  esac
  ssh $@
}
alias ssh='ssh_change_profile'
