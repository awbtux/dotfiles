#!/bin/zsh

# prompt function
precmd() {
    # initialize
    unset gitchanges gitbranch gitcommit

    # git information for prompt
    command -v git >/dev/null 2>&1 && {
        git status >/dev/null 2>&1 && {
            gitbranch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" 2>/dev/null
            gitcommit="$(git rev-parse --short HEAD 2>/dev/null)" 2>/dev/null
            git status | grep Changes >/dev/null 2>&1 && gitchanges="y"
        }
    }

    # print the prompt
    case "$TERM" in
        foot|*color|*color*|linux)
            eval "export PROMPT=\"$(printf "\033[1;35m%%n@%%m${gitbranch:+\033[0m:\033[1;32m${gitbranch}${gitchanges:+\033[31m*}}\033[0m:\033[1;34m$(pathabbrev "$PWD")\033[0m%%(!.#.$) ")\""
            ;;
        *)
            eval "export PROMPT=\"%n@%m${gitbranch:+:$gitbranch${gitchanges:+*}}:$(pathabbrev "$PWD")%$ \""
            ;;
    esac
}
