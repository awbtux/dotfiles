#!/bin/sh

# shell prompt based on permission level
case "${EUID:-${UID:-$(id -u)}}" in
    0) PS1="# " ;;
    *) PS1='$ ' ;;
esac

# command splitting into multiple lines
PS2=">"

# 'select' menu
PS3="#? "

# output tracing
PS4="++ "
