#!/bin/sh

# cd to lf's last path upon exit

# ensure lf is installed
command -v lf >/dev/null 2>&1 || return

# function
lfcd() {
    unalias lf
    _cd "$(lf -print-last-dir "$@")"
    alias lf="lfcd"
}

alias lf="lfcd"
