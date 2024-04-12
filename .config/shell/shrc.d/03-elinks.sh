#!/bin/sh

# prevent elinks from creating junk in ~, and spoof the terminal name if applicable

# ensure lf is installed
command -v elinks >/dev/null 2>&1 || return

# run elinks as usual, and then clean up after it
_elinks() {
    unalias elinks
    elinks "$@"
    rm "$HOME/.rnd" >/dev/null 2>&1
    alias elinks="_elinks"
}

# use custom elinks function
alias elinks="_elinks"

# lie to elinks about the terminal type if running
# under a multiplexer (eg. tmux/screen)
test "$TERM" = "screen-256color" && alias _elinks="TERM=xterm-256color _elinks"
