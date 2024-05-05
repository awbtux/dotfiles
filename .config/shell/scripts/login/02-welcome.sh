#!/bin/sh

# login welcome message
command -v awk >/dev/null 2>&1 && test -r "/etc/passwd" && {
    printf "\n\033[1mWelcome back, \033[34m%s\033[39m!\033[22m\n" "$(awk -F: "/${USERNAME:-${USER:=${LOGNAME:-$(whoami 2>/dev/null || logname 2>/dev/null || id -un 2>/dev/null || ps -o user= -p "$$" 2>/dev/null || printf "${HOME##*/}")}}}/ {print \$5}" </etc/passwd| awk -F' ' '{print $1}')"
} || {
    printf "\n\033[1mWelcome back, \033[34m%s\033[39m!\033[22m\n" "${USERNAME:-${USER:=${LOGNAME:-$(whoami 2>/dev/null || logname 2>/dev/null || id -un 2>/dev/null || ps -o user= -p "$$" 2>/dev/null || printf "${HOME##*/}")}}}"
}
