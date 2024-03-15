#!/bin/yash

# prompt function
print_prompt() {
    # initialize
    unset gitchanges gitbranch gitcommit

    # get hostname
    [ -z "$HOSTNAME" ] && read -r HOSTNAME </etc/hostname

    # git information for prompt
    command -v git >/dev/null 2>&1 && {
        git status >/dev/null 2>&1 && {
            gitbranch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" 2>/dev/null
            gitcommit="$(git rev-parse --short HEAD 2>/dev/null)" 2>/dev/null
            git status | grep Changes >/dev/null 2>&1 && gitchanges="y"
        }
    }

    # print the prompt
    case "$TERM" in
        foot|*color|*color*|linux)
            printf "\[\033[1;35m\]${USER:-$LOGNAME}@${HOSTNAME}${gitbranch:+\[\033[0m\]:\[\033[1;32m\]${gitbranch}${gitchanges:+\[\033[31m\]*}}\[\033[0m\]:\[\033[1;34m\]$(pathabbrev "$PWD")\[\033[0m\]\\\$ "
            ;;
        *)
            printf "${USER:-$LOGNAME}@${HOSTNAME}:${gitbranch:+:$gitbranch${gitchanges:+*}}:$(pathabbrev "$PWD")\\\$ "
            ;;
    esac
}
