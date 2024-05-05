#!/bin/yash

# prevent npm from creating junk in ~

# ensure lf is installed
command -v npm >/dev/null 2>&1 || return

# run npm as usual, and then clean up after it
_npm() {
    command npm "$@"
    rm -rf "$HOME/.npm" >/dev/null 2>&1
}

# use custom npm function
alias npm="_npm"
