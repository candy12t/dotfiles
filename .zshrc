if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# zstyle ':completion:*:*:git:*' script ~/.zsh/completion/.git-completion.bash
# fpath=($HOME/.zsh/completion $fpath)

autoload -U compinit
compinit -u

# precmd() { print "" }

if [ $(uname) = 'Linux' ]; then
	alias ls='ls -F --color'
else
	alias ls='ls -FG'
fi
alias brew='PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew' 
alias la='ls -A'
alias ll='ls -Al'

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

eval "$(starship init zsh)"
export STARSHIP_CONFIG=$HOME/.starship.toml

# setopt PROMPT_SUBST
# source ~/.git-prompt.sh
# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWUNTRACKEDFILES=1

# PS1='%F{magenta}%*%f %F{cyan}%~%f%B%F{green}$(__git_ps1 " [%s]")%f%b
# 🤔.oO( '
