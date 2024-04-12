#!/bin/yash

# prompt function
set_ps1() {
    # initialize
    unset gch gbr

    # git information for prompt
    command -v git >/dev/null 2>&1 && git status >/dev/null 2>&1 && {
        gbr="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" 2>/dev/null
        gch="$(git status | grep Changes >/dev/null 2>&1 && printf "y")" 2>/dev/null
    }

    # set prompt
    PS1="$(printf "\[\033[1;35m\]${USER:-$LOGNAME}@${HOSTNAME:-$(hostname 2>/dev/null || cat /proc/sys/kernel/hostname 2>/dev/null || printf "localhost")}${gbr:+\[\033[0m\]:\[\033[1;32m\]${gbr}${gch:+\[\033[31m\]*}}\[\033[0m\]:\[\033[1;34m\]$(pathabbrev "$PWD")\[\033[0m\]\\\$ ")"
}
