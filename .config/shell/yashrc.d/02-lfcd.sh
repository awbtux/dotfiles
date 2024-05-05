#!/bin/yash

# cd to lf's last path upon exit

# ensure lf is installed
command -v lf >/dev/null 2>&1 || return

# function
lfcd() {
    cd "$(command lf -print-last-dir "$@")"
}

alias lf="lfcd"
