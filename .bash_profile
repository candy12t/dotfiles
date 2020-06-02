export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
alias brew='PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin brew'
export PATH="/usr/local/sbin:$PATH"
export PATH=/Users/takumi/.nodebrew/current/bin:/Users/takumi/.rbenv/shims:/usr/local/sbin:/Users/takumi/.pyenv/shims:/Users/takumi/.pyenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin
export PATH="/usr/local/Cellar/postgresql@10/10.12_1/bin/:$PATH"

if [ -f ~/.bashrc ] ; then
  . ~/.bashrc
fi
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export GOENV_ROOT=/Users/takumi/.goenv
export PATH=/Users/takumi/.goenv/bin:/usr/local/opt/ncurses/bin:/usr/local/Cellar/postgresql@10/10.12_1/bin/:/Users/takumi/.nodebrew/current/bin:/Users/takumi/.rbenv/shims:/usr/local/sbin:/Users/takumi/.pyenv/shims:/Users/takumi/.pyenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
