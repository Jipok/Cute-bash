# Cute-bash
Useful default settings for bash in one file

![image](https://user-images.githubusercontent.com/25588359/107625132-c6e65000-6c53-11eb-8673-80a8c9febdd4.png)

## Features
- One file. Easy installation
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
- Alias `mkcd` - make and change directory at once
- Aliases `ls`, `la`, `l`, `gitlog`, `gotree`
- Universal commands for extracting(`extract`) and packing(`pk`) archives
- Will use [bash-completion](https://github.com/scop/bash-completion), if installed
- Will provide new commands `cd` and `fkill`, if `fzf` installed
- Automatically downloads and uses [LS_COLORS](https://github.com/trapd00r/LS_COLORS) 
([Screenshot](https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/docs/static/LS_COLORS.png))
- On each login will connects to `tmux` session if available 

## Installation

Per user:
`wget https://raw.githubusercontent.com/Jipok/Cute-bash/master/.bashrc -O ~/.bashrc`

System-wide:
`https://raw.githubusercontent.com/Jipok/Cute-bash/master/.bashrc -O /etc/bash.bashrc`

Of course this will replace the original files if they were. 

