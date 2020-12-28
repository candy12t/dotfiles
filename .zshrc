if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# zstyle ':completion:*:*:git:*' script ~/.zsh/completion/.git-completion.bash
# fpath=($HOME/.zsh/completion $fpath)

autoload -U compinit
compinit -u

# [[ $- != *i* ]] && return
# [[ -z "$TMUX" ]] && exec tmux

# precmd() { print "" }

if [ $(uname -s) = 'Linux' ];then
	alias ls='ls -F --color'
else
	alias ls='ls -FG'
	alias brew='PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew'
fi
alias la='ls -A'
alias ll='ls -Al'
alias g='git'
alias t='tmux'
alias ts='tig status'

alias dk='docker'
alias dki='docker images'
alias dkrmi='docker rmi'
alias dkrm='docker rm'
alias dkp='docker ps'
alias dkP='docker ps -a'

alias dkc='docker-compose'
alias dkcl='docker-compose logs'
alias dkcL='docker-compose logs -ft'
alias dkcb='docker-compose build'
alias dkcd='docker-compose down'
alias dkcD='docker-compose down -v'
alias dkcR='docker-compose run --rm'
alias dkcu='docker-compose up'
alias dkcU='docker-compose up -d'
alias dkcp='docker-compose ps'


export PYENV_ROOT="$HOME/.pyenv"
if [ -e ${PYENV_ROOT} ];then
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
fi

export GOENV_ROOT="$HOME/.goenv"
if [ -e ${GOENV_ROOT} ];then
	export PATH="$GOENV_ROOT/bin:$PATH"
	eval "$(goenv init -)"
	export PATH="$GOROOT/bin:$PATH"
	export PATH="$PATH:$GOPATH/bin"
	export GOENV_DISABLE_GOPATH=1
	export GOPATH=$HOME/dev/go
fi

export RBENV_ROOT="$HOME/.rbenv"
if [ -e ${RBENV_ROOT} ];then
	export PATH="$RBENV_ROOT/bin:$PATH"
	eval "$(rbenv init -)"
fi

export NODENV_ROOT="$HOME/.nodenv"
if [ -e ${NODENV_ROOT} ];then
  export PATH="$NODENV_ROOT/bin:$PATH"
  eval "$(nodenv init -)"
fi

if [ -d "/usr/local/opt/postgresql@9.6" ];then
	export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
fi


export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 60% --border horizontal --reverse --preview "bat --color=always --style=grid -r :15 {}"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


if [ -x $(which starship) ];then
	eval "$(starship init zsh)"
	export STARSHIP_CONFIG=$HOME/.starship.toml
fi

source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

# setopt PROMPT_SUBST
# source ~/.git-prompt.sh
# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWUNTRACKEDFILES=1

# PS1='%F{magenta}%*%f %F{cyan}%~%f%B%F{green}$(__git_ps1 " [%s]")%f%b
# 🤔.oO( '
