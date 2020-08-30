if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# zstyle ':completion:*:*:git:*' script ~/.zsh/completion/.git-completion.bash
# fpath=($HOME/.zsh/completion $fpath)

autoload -U compinit
compinit -u

# precmd() { print "" }

if [ $(uname -s) = 'Linux' ];then
	alias ls='ls -F --color'
else
	alias ls='ls -FG'
	alias brew='PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew' 
fi
alias la='ls -A'
alias ll='ls -Al'

export PYENV_ROOT="$HOME/.pyenv"
if [ -e ${PYENV_ROOT} ];then
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
fi

export GOPATH=$HOME/go
if [ -e ${GOPATH} ];then
	export PATH="$PATH:$GOPATH/bin"
fi

export RBENV_ROOT="$HOME/.rbenv"
if [ -e ${RBENV_ROOT} ];then
	export PATH="$RBENV_ROOT/bin:$PATH"
	eval "$(rbenv init -)"
fi

if [ -d "/usr/local/opt/postgresql@9.6" ];then
	export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
fi

if [ -x $(which starship) ];then
	eval "$(starship init zsh)"
	export STARSHIP_CONFIG=$HOME/.starship.toml
fi

# setopt PROMPT_SUBST
# source ~/.git-prompt.sh
# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWUNTRACKEDFILES=1

# PS1='%F{magenta}%*%f %F{cyan}%~%f%B%F{green}$(__git_ps1 " [%s]")%f%b
# 🤔.oO( '
