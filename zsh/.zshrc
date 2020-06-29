zstyle ':completion:*:*:git:*' script ~/.zsh/completion/.git-completion.bash
fpath=($HOME/.zsh/completion $fpath)

autoload -U compinit
compinit -u

alias brew='PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew' 
alias ls='ls -FG'
alias la='ls -a'
alias ll='ls -al'

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

setopt PROMPT_SUBST
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

PS1='
%F{magenta}%*%f %F{cyan}%~%f%B%F{green}$(__git_ps1 " [%s]")%f%b
🤔.oO( '
