#!/bin/bash

# prompt function
set_ps1() {
    # initialize
    unset gch gbr

    # git information for prompt
    command -v git >/dev/null 2>&1 && git status >/dev/null 2>&1 && {
        gbr="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" 2>/dev/null
        gch="$(git status | grep Changes >/dev/null 2>&1 && printf "y")" 2>/dev/null
    }

    # print the prompt
    PS1="\[\033[1;35m\]\\u@\\h${gbr:+\[\033[0m\]:\[\033[1;32m\]${gbr}${gch:+\[\033[31m\]*}}\[\033[0m\]:\[\033[1;34m\]\\w\[\033[0m\]\\\$ "
}
