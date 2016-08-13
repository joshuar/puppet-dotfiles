### TERMINAL COLOUR SUPPORT
if [[ "$TERM" = "xterm" ]] && [[ -z "$COLORTERM" ]]; then
    TERM="xterm-256color"
elif [[ "$COLORTERM" = "gnome-terminal" ]]; then
    # Those crafty Gnome folks require you to check COLORTERM,
    # but don't allow you to just *favor* the setting over TERM.
    # Instead you need to compare it and perform some guesses
    # based upon the value. This is, perhaps, too simplistic.
    TERM="gnome-256color"
fi
### SOURCE SYSTEM CONFIG
# Gentoo:
if [[ -e /etc/gentoo-release ]] && [[ -r /etc/profile.d/bash-completion.sh ]]; then
    . /etc/profile.d/bash-completion.sh
fi
# Fedora/CentOS:
if [[ -e /etc/fedora-release ]] || [[ -e /etc/centos-release ]]; then
    [[ -f /etc/bashrc ]] && . /etc/bashrc
    if [[ $PS1 ]] && [[ -r /usr/share/bash-completion/bash_completion ]]; then
        . /usr/share/bash-completion/bash_completion
    fi
fi
# Debian:
if [[ -e /etc/debian_version ]]; then
    test -r /etc/bash.bashrc && . /etc/bash.bashrc
fi

### MISC ENVIRONMENT VARIABLES
export EDITOR='emacs'
export VISUAL='emacs'
export GOPATH=${HOME}/gocode
export WINEARCH=win32

umask 022

### HISTORY SETTINGS
export HISTSIZE='5000'
export HISTIGNORE="cd:cd -:cd ..:ls:df:df -h:du:du -h:[bf]g:history:root:exit:htop:top:iotop:dmesg:w:who"
export HISTCONTROL='ignoredups'
export HISTTIMEFORMAT='%a %d %l:%M%p '

### VARIABLES
# minor spell-checking of cd command and
shopt -sq cdspell
# check window size after every command:
shopt -sq checkwinsize
# save multiple-line cmds to single history entry:
shopt -sq cmdhist
# append to history file, rather than overwriting:
shopt -sq histappend
# if the history substitution failed it is automatically
# re-inserted to your current command line buffer.
shopt -sq histreedit
# don't run the substituted command right away, only put
# it to your current command line buffer.
shopt -s histverify
# don't attempt to search the PATH for possible completions when completion
# is attempted on an empty line:
shopt -sq no_empty_cmd_completion
# extended glob options
shopt -sq extglob
# Bash v4 and above shell options:
if [[ $(bash --version | grep 'version 4') ]]; then
    # spell correction on directory names during word completion:
    shopt -sq dirspell
    # list the status of any stopped and running jobs before exiting an
    # interactive shell:
    shopt -sq checkjobs
    # Type only the name of the directory
    # (without cd) to enter it.
    shopt -s autocd
fi

### PATH SETTINGS
export PATH=${PATH#:}
test -d ~/scripts && export PATH="${HOME}/scripts:${PATH}"
test -d "${GOPATH}/bin" && export PATH="${GOPATH}/bin:${PATH}"

### APP SETTINGS
if type -P less >/dev/null; then
    export PAGER='less'
    export LESS='FgJMqRw --follow-name'
fi
# LaTeX customisations in ~/texmf, supported by texlive
if type -P latex >/dev/null; then
    export TEXINPUTS=".:${HOME}/texmf:"
    export BIBINPUTS=".:${HOME}/texmf/bibtex:"
    export BSTINPUTS=${BIBINPUTS}
fi
# for tmux: export 256color
[[ -n $TMUX ]] && export TERM=screen-256color

# Source the aliases file
[[ -r ~/.bash_alias ]] && . ~/.bash_alias

# If PS1 is set (interactive session)
if [[ -n $PS1 ]]; then
    # Disable START/STOP flow control
    stty -ixon -ixoff
    # Create prompt with bash-powerline
    if [[ -f `which powerline-daemon` ]]; then
        powerline-daemon -q
        POWERLINE_BASH_CONTINUATION=1
        POWERLINE_BASH_SELECT=1
        if [[ -r /usr/share/powerline/bash/powerline.sh ]]; then
            . /usr/share/powerline/bash/powerline.sh
        elif [[ -r /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]]; then
            . /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
        fi
    fi
fi

### If Google cloud SDK installed, source it
if [[ -e ~/google-cloud-sdk ]]; then
    . ~/google-cloud-sdk/path.bash.inc
    . ~/google-cloud-sdk/completion.bash.inc
fi

# set a DEBUG trap to reset text color after pressing enter
#trap 'echo -ne "\e[0m"' DEBUG

# Local Variables:
# mode: shell
# End:
