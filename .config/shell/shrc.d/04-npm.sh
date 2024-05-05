#!/bin/sh

# prevent npm from creating junk in ~

# some stupid shells don't support aliases
command -v alias >/dev/null 2>&1 || return

# ensure lf is installed
command -v npm >/dev/null 2>&1 || return

# run npm as usual, and then clean up after it
_npm() {
    unalias npm
    npm "$@"
    rm -rf "$HOME/.npm" >/dev/null 2>&1
    alias npm="_npm"
}

# use custom npm function
alias npm="_npm"
