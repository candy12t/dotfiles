alias ls='ls -FG'
alias ll='ls -al'


# コマンド実行後改行
function add_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}
PROMPT_COMMAND='add_line'


source ~/.git-completion.bash
source ~/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWSTASHSTATE=1

# プロンプトカスタマイズ
#
# \h ホスト名
# \w ディレクトリパス
# \n 改行
# 
# \[\e[1;34m\] 太文字&&青文字
# \[\e[1;32m\] 太文字&&緑文字
# \[\e[0m\] 無装飾
export PS1='\[\e[35m\]\t🍕\[\e[36m\]\u:\[\e[1;34m\]\w\[\e[1;32m\]$(__git_ps1) \[\e[0m\]\n> '
