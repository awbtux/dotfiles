#!/bin/sh

printf "\n"

# run the deploy script if required
test -r "${XDG_DATA_HOME:-$HOME/.local/share}/dots/.configured.txt" && return

# run deploy-dots if it's available
command -v deploy-dots >/dev/null 2>&1 && deploy-dots
