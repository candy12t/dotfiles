# how to use italic character in terminal with tmux

1. run `tic` command

```bash
tic xterm-256color-italic.terminfo
```

2. add tmux setting

```tmux
set -g default-terminal 'xterm-256color-italic'
```

3. check

```bash
echo -e "\e[1mbold\e[0m"
echo -e "\e[3mitalic\e[0m"
echo -e "\e[3m\e[1mbold italic\e[0m"
echo -e "\e[4munderline\e[0m"
echo -e "\e[9mstrikethrough\e[0m"
echo -e "\e[31mHello World\e[0m"
echo -e "\x1B[31mHello World\e[0m"
```
