#!/bin/sh

# abbreviate a path
pathabbrev() {
    case "$1" in
        "$HOME"*) printf "~${1##$HOME}" ;;
               *) printf "$1" ;;
    esac
}

# whether or not our terminal has color support
has_color() {
    test "$TERM" != "${TERM##*color*}" -o "$TERM" = "linux"
}

# most POSIX-compliant shells don't support prompt expansion, but we can do
# this ourselves by executing this function every time the shell forks a child
# process; this is also ran when changing directories
set_ps1() {
    trap - CHLD
    PS1="${HOSTNAME:=$(hostname 2>/dev/null || uname -n 2>/dev/null || hostnamectl --static 2>/dev/null || cat /proc/sys/kern/hostname 2>/dev/null || cat /proc/sys/kernel/hostname 2>/dev/null || cat /etc/hostname 2>/dev/null)}"
    PS1="${USERNAME:-${USER:=${LOGNAME:-$(whoami 2>/dev/null || logname 2>/dev/null || id -un 2>/dev/null || ps -o user= -p "$$" 2>/dev/null || printf "${HOME##*/}")}}}${PS1:+@$PS1}"
    PS1="${PS1:+$(has_color && printf "\033[1;35m")$PS1$(has_color && printf "\033[0m")}"
    PS1="${PS1:+$PS1:}$(has_color && printf "\033[1;34m")$(pathabbrev "$PWD")$(has_color && printf "\033[0m")"
    PS1="$(printf "%s%s " "$PS1" "$(test "${EUID:=${UID:-$(id -u)}}" = "0" && printf '#' || printf '$')")"
    trap 'set_ps1' CHLD
    return 0
}
# add to set_ps1 for git integration
#PS1="$PS1$(test -n "$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" && printf ":$(has_color && printf "\033[1;32m")$(git rev-parse --abbrev-ref HEAD 2>/dev/null)$(has_color && printf "\033[0m")")"
#PS1="$PS1$(test -n "$(git status 2>/dev/null | grep Changes >/dev/null 2>&1 && printf "y")" && printf "$(has_color && printf "\033[1;31m")*$(has_color && printf "\033[0m")")"

# set the prompt using the function
# by default, the shell also runs this when forking child processes; if you
# don't want that, comment/remove lines that set the CHLD trap to disable it
set_ps1

# change the behavior of cd, pushd, and popd to run the 'set_ps1' function
# whenever the working directory is changed
for i in cd pushd popd; do
    eval "_$i() { unalias $i; $i \"\$@\"; set_ps1; alias $i=\"_$i\"; }; alias $i=_$i"
done
