#!/bin/sh

# wait before clearing screen to debug previous login scripts
#sleep 5

# hide previous sessions/login attempts by clearing the screen
printf "\033[H\033[2J\033[3J"
