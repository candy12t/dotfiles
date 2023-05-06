# how to use italic character in terminal with tmux

1. run `tic` command

```bash
tic xterm-256color-italic.terminfo
```

2. add tmux setting

```tmux
set -g default-terminal 'xterm-256color-italic'
```
