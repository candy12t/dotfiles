if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -U compinit
compinit -u

if [ $(uname -s) = 'Linux' ]; then
  alias ls='ls -F --color'
else
  alias ls='ls -FG'
  alias brew='PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin brew'
fi
alias la='ls -A'
alias ll='ls -Al'
alias g='git'
alias t='tmux'
alias ts='tig status'


# python
export PYENV_ROOT="$HOME/.pyenv"
if [ -e ${PYENV_ROOT} ]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi

# go
export GOENV_ROOT="$HOME/.goenv"
if [ -e ${GOENV_ROOT} ]; then
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
  export PATH="$GOROOT/bin:$PATH"
  export GOENV_DISABLE_GOPATH=1
  export GOPATH=$HOME/dev/go
  export PATH="$PATH:$GOPATH/bin"
fi

# ruby
export RBENV_ROOT="$HOME/.rbenv"
if [ -e ${RBENV_ROOT} ]; then
  export PATH="$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init -)"
fi

# node
export NODENV_ROOT="$HOME/.nodenv"
if [ -e ${NODENV_ROOT} ]; then
  export PATH="$NODENV_ROOT/bin:$PATH"
  eval "$(nodenv init -)"
fi

# postgresql@9.6
if [ -d "/usr/local/opt/postgresql@9.6" ]; then
  export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
fi


# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 60% --border horizontal --reverse --preview "bat --color=always --style=grid -r :15 {}"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# starship
if [ -x $(which starship) ]; then
  eval "$(starship init zsh)"
fi

# gcloud
if [ -d "/usr/local/Caskroom/google-cloud-sdk" ]; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
fi

# rust
# how to install rustup (ref: "https://www.rust-lang.org/tools/install")
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
export CARGO_ROOT="$HOME/.cargo"
if [ -e ${CARGO_ROOT} ]; then
  source "$HOME/.cargo/env"
fi

if [ -x $(which direnv) ]; then
  eval "$(direnv hook zsh)"
fi
