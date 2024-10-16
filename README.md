# Cute-bash
Useful default settings for bash in one file

![image](https://user-images.githubusercontent.com/25588359/107625132-c6e65000-6c53-11eb-8673-80a8c9febdd4.png)

## Features
- Easy installation
- Includes [bash-sensible](https://github.com/mrzool/bash-sensible):
- - Smarter tab completion
- - Saner history defaults
- - *Mod*: persistent history
- - Faster file system navigation
- Includes [bash-powerline](https://github.com/riobard/bash-powerline)
- - Short and informative promt 
- - Git: show branch name, tag name, or unique short hash
- - Git: show numbers of commits ahead of remote/behind remote
- - Use Bash builtin when possible to reduce delay. **Delay sucks!**
- - Platform-dependent prompt symbols
- - *Mod*: Shows the hostname when logging in via ssh
- Colored less
- Uses user aliases(and other settings) from `~/.bash-user`
- Alias `mkcd` - make and change directory at once
- Alias `t` - tmux attach or new session with mouse support
- Aliases `ls`, `la`, `l`, `gitlog`, `gittree`
- Universal commands for extracting(`extract`), `list` and packing(`pk`) archives
- Will provide new commands `cd` and `fkill`, if `fzf` installed
- Automatically downloads and uses [bash-completion](https://github.com/scop/bash-completion)
- Automatically downloads and uses [LS_COLORS](https://github.com/trapd00r/LS_COLORS) 
([Screenshot](https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/docs/static/LS_COLORS.png))
- Automatically downloads and uses [complete_alias](https://github.com/cykerway/complete-alias) 
- On each login will notify if `tmux` session available 

## Installation

Per user:
`wget https://raw.githubusercontent.com/Jipok/Cute-bash/master/.bashrc -O ~/.bashrc`

System-wide(debian, arch):

```bash
wget https://raw.githubusercontent.com/Jipok/Cute-bash/master/.bashrc -O /etc/bash.bashrc
mkdir /etc/bash
wget "https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS" -O /etc/bash/ls_colors
wget "https://raw.githubusercontent.com/cykerway/complete-alias/master/complete_alias" -O /etc/bash/complete_alias
wget "https://raw.githubusercontent.com/scop/bash-completion/2.11/bash_completion" -O /etc/bash/bash-completion-2.11
```

System-wide(void linux):

```bash
wget https://raw.githubusercontent.com/Jipok/Cute-bash/master/.bashrc -O /etc/bash/bashrc
wget "https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS" -O /etc/bash/ls_colors
wget "https://raw.githubusercontent.com/cykerway/complete-alias/master/complete_alias" -O /etc/bash/complete_alias
wget "https://raw.githubusercontent.com/scop/bash-completion/2.11/bash_completion" -O /etc/bash/bash-completion-2.11
```

Of course this will replace the original files if they were. Also recommend `sudo rm /etc/skel/.bashrc` 

