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
- Aliases `ls`, `la`, `l`, `gitlog`, `gittree`
- Universal commands for extracting(`extract`), `list` and packing(`pk`) archives
- Will provide new commands `cd` and `fkill`, if `fzf` installed
- Automatically downloads and uses [LS_COLORS](https://github.com/trapd00r/LS_COLORS) 
([Screenshot](https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/docs/static/LS_COLORS.png))
- Automatically downloads and uses [complete_alias](https://github.com/cykerway/complete-alias) 
- On each login will notify if `tmux` session available 
- Enhanced tmux integration `t`:
  - Attach to existing session or create new one with mouse support
  - Run as different user with `t username`

## Requirements
- Bash 4.0+
- tmux (optional, for tmux integration)
- fzf (optional, for enhanced cd/kill commands)

## Installation

Per user:
```
wget https://raw.githubusercontent.com/Jipok/Cute-bash/master/.bashrc -O ~/.bashrc
echo '[ -f ~/.bashrc ] && source ~/.bashrc' >> ~/.bash_profile
```

System-wide(debian, arch):

```bash
wget https://raw.githubusercontent.com/Jipok/Cute-bash/master/.bashrc -O /etc/bash.bashrc
mkdir /etc/bash
wget "https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS" -O /etc/bash/ls_colors
wget "https://raw.githubusercontent.com/cykerway/complete-alias/master/complete_alias" -O /etc/bash/complete_alias
```

System-wide(void linux):

```bash
wget https://raw.githubusercontent.com/Jipok/Cute-bash/master/.bashrc -O /etc/bash/bashrc.d/cute-bash.sh
wget "https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS" -O /etc/bash/ls_colors
wget "https://raw.githubusercontent.com/cykerway/complete-alias/master/complete_alias" -O /etc/bash/complete_alias
```

Of course this will replace the original files if they were. Also recommend `sudo rm /etc/skel/.bashrc` 

## Customization


Create `~/.bash-user` to add your own aliases and settings. Example:
```bash
# Custom aliases
alias projects='cd ~/projects'
alias gs='git status'

# Custom environment variables
export EDITOR=nvim

# Disable git status
POWERLINE_GIT=0
```

## Troubleshooting

**Prompt symbols not displaying correctly**
   - Make sure your terminal supports UTF-8
   - Try installing a powerline-compatible font like https://nerdfonts.com