#!/usr/bin/env bash
PATH="$PATH:$HOME/.local/bin"
export TERM=xterm-256color

# Make and change directory at once
alias mkcd='_(){ mkdir -p "$(echo $@)"; cd "$(echo $@)"; }; _'

# Tmux attach or new with mouse support
alias t='tmux set-option -g mouse on \; attach || tmux set-option -g mouse on \; new'

# Display the local time and the delta in human-readable format
alias dmesg='dmesg -e'

alias ls='ls --color=auto'
alias la='ls -a'
alias l='ls -alh'

alias gitlog="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr %an)%Creset' --abbrev-commit --date=relative"
alias gittree="git log --graph --date=short --branches --pretty=format:'%C(yellow)%h%C(reset) %ad | %C(75)%s%C(reset) %C(yellow)%d%C(reset) [%an]'"

# Default parameter to send to the "less" command
# -R: show ANSI colors correctly; -i: case insensitive search
export LESS="-R -i"
# Colored man
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;45;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline


# FZF kill processes - list only the ones you can kill. Modified the earlier script.
hash fzf &> /dev/null && \
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# FZF change dirrectory
hash fzf &> /dev/null && \
function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}

# Universal extract command
# example: extract file
extract () {
    if [ ! -f "$1" ] ; then
        echo "'$1' does not exist"
        return 1
    fi

    case $1 in
        *.tar.bz2)  tar xjf "$1"  ;;
        *.tar.gz)   tar xzf "$1"  ;;
        *.tar.xz)   tar xpJf "$1" ;;
        *.tar)      tar xvf "$1"  ;;
        *.bz2)      bunzip2 "$1"  ;;
        *.rar)      unrar x "$1"  ;;
        *.gz)       gunzip "$1"   ;;
        *.tar)      tar xf "$1"   ;;
        *.tbz2)     tar xjf "$1"  ;;
        *.tbz)      tar -xjvf "$1";;
        *.tgz)      tar xzf "$1"  ;;
        *.zip)      unzip "$1"    ;;
        *.Z)        uncompress $1 ;;
        *.7z)       7z x "$1"     ;;
        *.xz)       unxz "$1"     ;;
        *)          echo "I don't know how to extract '$1'..." ;;
    esac
}

# Universal packaging command
# example: pk tar file
pk () {
    if [ ! -e "$2" ] ; then
        echo "'$1' does not exist"
        return 1
    fi

    case $1 in
        tbz)        tar cjvf "$"2.tar.bz2 "$2"   ;;
        tgz)        tar czvf "$2".tar.gz  "$2"   ;;
        tar)        tar cpvf "$2".tar  "$2"      ;;
        bz2)        bzip "$2"                  ;;
        gz)         gzip -c -9 -n "$2" > "$2".gz ;;
        zip)        zip -r "$2".zip "$2"         ;;
        7z)         7z a "$2".7z "$2"            ;;
        *)          echo "'$1' cannot be packed via pk()" ;;
    esac
}


# MODIFIED https://github.com/riobard/bash-powerline
__powerline() {
    # Colorscheme
    RESET='\[\033[m\]'
    COLOR_CWD='\[\033[0;34m\]' # blue
    COLOR_GIT='\[\033[0;36m\]' # cyan
    COLOR_SUCCESS='\[\033[0;32m\]' # green
    COLOR_FAILURE='\[\033[0;31m\]' # red

    SYMBOL_GIT_BRANCH=''
    #SYMBOL_GIT_MODIFIED='*'
    SYMBOL_GIT_MODIFIED=' '
    SYMBOL_GIT_PUSH='↑'
    SYMBOL_GIT_PULL='↓'

    if [[ -z "$PS_SYMBOL" ]]; then
      case "$(uname)" in
          Darwin)   PS_SYMBOL='';;
          Linux)    PS_SYMBOL='\$';;
          *)        PS_SYMBOL='%';;
      esac
    fi

    __git_info() {
        [[ $POWERLINE_GIT = 0 ]] && return # disabled
        hash git 2>/dev/null || return # git not found
        local git_eng="env LANG=C git"   # force git output in English to make our work easier

        # get current branch name
        local ref=$($git_eng symbolic-ref --short HEAD 2>/dev/null)

        if [[ -n "$ref" ]]; then
            # prepend branch symbol
            ref=$SYMBOL_GIT_BRANCH'['$ref']'
        else
            # get tag name or short unique hash
            ref=$($git_eng describe --tags --always 2>/dev/null)
        fi

        [[ -n "$ref" ]] || return  # not a git repo

        local marks

        # scan first two lines of output from `git status`
        while IFS= read -r line; do
            if [[ $line =~ ^## ]]; then # header line
                [[ $line =~ ahead\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PUSH${BASH_REMATCH[1]}"
                [[ $line =~ behind\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PULL${BASH_REMATCH[1]}"
            else # branch is modified if output contains more lines after the header line
                marks="$SYMBOL_GIT_MODIFIED$marks"
                break
            fi
        done < <($git_eng status --porcelain --branch 2>/dev/null)  # note the space between the two <

        # print the git branch segment without a trailing newline
        printf " $ref$marks"
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly.
        if [ $? -eq 0 ]; then
            local symbol="$COLOR_SUCCESS $PS_SYMBOL $RESET"
        else
            local symbol="$COLOR_FAILURE $PS_SYMBOL $RESET"
        fi

        local cwd="$COLOR_CWD\w$RESET"
        # Bash by default expands the content of PS1 unless promptvars is disabled.
        # We must use another layer of reference to prevent expanding any user
        # provided strings, which would cause security issues.
        # POC: https://github.com/njhartwell/pw3nage
        # Related fix in git-bash: https://github.com/git/git/blob/9d77b0405ce6b471cb5ce3a904368fc25e55643d/contrib/completion/git-prompt.sh#L324
        if shopt -q promptvars; then
            __powerline_git_info="$(__git_info)"
            local git="$COLOR_GIT\${__powerline_git_info}$RESET"
        else
            # promptvars is disabled. Avoid creating unnecessary env var.
            local git="$COLOR_GIT$(__git_info)$RESET"
        fi

        # Print hostname for remote connections
        if [ -z "$(w -i | grep -P '([0-9]{1,3}[\.]){3}[0-9]{1,3}')" ]; then
            PS1="$cwd$git$symbol"
        else
            PS1="\[\033[01;32m\]\u@\h\[\033[00m\]: $cwd$git$symbol"
        fi

        if [ -n "$VIRTUAL_ENV" ]; then
            PS1="\033[0;33m($(basename "$VIRTUAL_ENV"))\033[m $PS1"
        fi
    }

    PROMPT_COMMAND="ps1${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
}


# MODIFIED https://github.com/mrzool/bash-sensible
__sensible () {
    # Sensible Bash - An attempt at saner Bash defaults
    # Maintainer: mrzool <http://mrzool.cc>
    # Repository: https://github.com/mrzool/bash-sensible
    # Version: 0.2.2

    # Unique Bash version check
    if ((BASH_VERSINFO[0] < 4))
    then
      echo "sensible.bash: Looks like you're running an older version of Bash."
      echo "sensible.bash: You need at least bash-4.0 or some options will not work correctly."
      echo "sensible.bash: Keep your software up-to-date!"
    fi

    ## GENERAL OPTIONS ##

    # Prevent file overwrite on stdout redirection
    # Use `>|` to force redirection to an existing file
    set -o noclobber

    # Update window size after every command
    shopt -s checkwinsize

    # Automatically trim long paths in the prompt (requires Bash 4.x)
    PROMPT_DIRTRIM=2

    # Enable history expansion with space
    # E.g. typing !!<space> will replace the !! with your last command
    bind Space:magic-space

    # Turn on recursive globbing (enables ** to recurse all directories)
    shopt -s globstar 2> /dev/null

    # Case-insensitive globbing (used in pathname expansion)
    shopt -s nocaseglob;

    ## SMARTER TAB-COMPLETION (Readline bindings) ##

    # Perform file completion in a case insensitive fashion
    bind "set completion-ignore-case on"

    # Treat hyphens and underscores as equivalent
    bind "set completion-map-case on"

    # Display matches for ambiguous patterns at first tab press
    bind "set show-all-if-ambiguous on"

    # Immediately add a trailing slash when autocompleting symlinks to directories
    bind "set mark-symlinked-directories on"

    ## SANE HISTORY DEFAULTS ##

    # Append to the history file, don't overwrite it
    shopt -s histappend

    # Save multi-line commands as one command
    shopt -s cmdhist

    # Record each line as it gets issued
    PROMPT_COMMAND='history -a'

    # Huge history. Doesn't appear to slow things down, so why not?
    HISTSIZE=500000
    HISTFILESIZE=1000000

    # Change the file location because certain bash sessions truncate .bash_history
    export HISTFILE=~/.history_bash
    
    # Avoid duplicate entries
    HISTCONTROL="erasedups:ignoreboth"

    # Don't record some commands
    export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

    # Use standard ISO 8601 timestamp
    # %F equivalent to %Y-%m-%d
    # %T equivalent to %H:%M:%S (24-hours format)
    HISTTIMEFORMAT='%F %T '

    # Enable incremental history search with up/down arrows (also Readline goodness)
    # Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    bind '"\e[C": forward-char'
    bind '"\e[D": backward-char'
    bind '"\e[P": delete-char'

    ## BETTER DIRECTORY NAVIGATION ##

    # Prepend cd to directory names automatically
    shopt -s autocd 2> /dev/null
    # Correct spelling errors during tab-completion
    shopt -s dirspell 2> /dev/null
    # Correct spelling errors in arguments supplied to cd
    shopt -s cdspell 2> /dev/null

    # This defines where cd looks for targets
    # Add the directories you want to have fast access to, separated by colon
    # Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
    # CDPATH="."

    # This allows you to bookmark your favorite places across the file system
    # Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
    shopt -s cdable_vars

    # Examples:
    # export dotfiles="$HOME/dotfiles"
    # export projects="$HOME/projects"
    # export documents="$HOME/Documents"
    # export dropbox="$HOME/Dropbox"
}


# Check we're in an interactive shell
if [[ $- = *i* ]]; then
    bind TAB:menu-complete
    # shift tab cycles backward
    __sensible

    __powerline
    #unset __powerline

    [[ -s "/usr/share/doc/fzf/key-bindings.bash" ]] && \
        source /usr/share/doc/fzf/key-bindings.bash

    # Use bash-completion, if available
    [ -f /usr/share/bash-completion/bash_completion ] && \
        source /usr/share/bash-completion/bash_completion

    # Download and use LS_COLORS
    if [ -f /etc/bash/ls_colors ]; then
        eval $( dircolors -b /etc/bash/ls_colors )
    else    
        if [ ! -f $HOME/.ls_colors ]; then
            wget "https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS" -O ~/.ls_colors
        fi
        eval $( dircolors -b $HOME/.ls_colors )
    fi

    # Notify about tmux session
    if command -v tmux &> /dev/null && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
        if tmux has-session &> /dev/null; then
            echo -e "\033[1m\tThere are tmux session.\033[m Type\033[0;32m\033[1m t\033[m to attach"
        fi
    fi
fi
