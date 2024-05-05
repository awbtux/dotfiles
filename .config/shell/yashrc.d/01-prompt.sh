#!/bin/yash

# abbreviate a path
pathabbrev() {
    case "$1" in
        "$HOME"*) printf "~${1##$HOME}" ;;
               *) printf "$1" ;;
    esac
}

# prompt function
set_ps1() {
    gbr="$(command -v git >/dev/null 2>&1 && git rev-parse --abbrev-ref HEAD 2>/dev/null)" 2>/dev/null
    gch="$(command -v git >/dev/null 2>&1 && git status 2>/dev/null | grep Changes >/dev/null 2>&1 && printf "y")" 2>/dev/null
    PS1="$(printf "\[\033[1;35m\]${USER:-$LOGNAME}@${HOSTNAME:-$(hostname 2>/dev/null || uname -n 2>/dev/null || hostnamectl --static 2>/dev/null || cat /proc/sys/kernel/hostname 2>/dev/null || cat /etc/hostname 2>/dev/null)}"
           test -n "$gbr" && printf "\[\033[0m\]:\[\033[1;32m\]%s" "$gbr"
           test -n "$gch" && printf "\[\033[31m\]*"
           printf "\[\033[0m\]:\[\033[1;34m\]%s\[\033[0m\]\\\$ " "$(pathabbrev "$PWD")")"
    return 0
}
