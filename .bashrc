alias ls='ls -FG'
alias la='ls -a'
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

# not add -> '*', add && not commit -> '+'
GIT_PS1_SHOWDIRTYSTATE=1
# new file -> '%'
GIT_PS1_SHOWUNTRACKEDFILES=1

# プロンプトカスタマイズ
#
# \t 時間
# \w ディレクトリパス
# \n 改行
# $(__git_ps1 " [%s]") git
#
export PS1='\[\e[1;35m\]\t \[\e[0;36m\]\w\[\e[1;32m\]$(__git_ps1 " [%s]") \[\e[0m\]\n🤔.oO( '