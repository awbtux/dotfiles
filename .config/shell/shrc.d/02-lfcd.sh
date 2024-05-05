#!/bin/sh

# cd to lf's last path upon exit

# some stupid shells don't support aliases
command -v alias >/dev/null 2>&1 || return

# ensure lf is installed
command -v lf >/dev/null 2>&1 || return

# function
lfcd() {
    unalias lf
    _cd "$(lf -print-last-dir "$@")"
    alias lf="lfcd"
}

alias lf="lfcd"
