#!/bin/sh

# login welcome message
command -v awk >/dev/null && [ -r "/etc/passwd" ] && {
    printf "\n\033[1mWelcome back, \033[34m$(awk -F: "/${USER:-${LOGNAME:-${HOME##*/}}}/ {print \$5}" </etc/passwd| awk -F' ' '{print $1}')\033[39m!\033[22m\n"
} || {
    printf "\n\033[1mWelcome back, \033[34m${USER:-${LOGNAME:-${HOME##*/}}}\033[39m!\033[22m\n"
}
