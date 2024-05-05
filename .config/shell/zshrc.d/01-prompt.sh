#!/bin/zsh

# prompt function
precmd() {
    gbr="$(command -v git >/dev/null 2>&1 && git rev-parse --abbrev-ref HEAD 2>/dev/null)" 2>/dev/null
    gch="$(command -v git >/dev/null 2>&1 && git status 2>/dev/null | grep Changes >/dev/null 2>&1 && printf "y")" 2>/dev/null
    PROMPT="$(printf "%%{\033[1;35m%%}%%n@%%m"
              test -n "$gbr" && printf "%%{\033[0m%%}:%%{\033[1;32m%%}%s" "$gbr"
              test -n "$gch" && printf "%%{\033[31m%%}*"
              printf "%%{\033[0m%%}:%%{\033[1;34m%%}%%~%%{\033[0m%%}%%(!.#.$) ")"
    return 0
}
