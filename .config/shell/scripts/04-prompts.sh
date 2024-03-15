#!/bin/sh

# shell prompt based on permission level
case "${EUID:-${UID:-$(id -u)}}" in
    0) export PS1="# " ;;
    *) export PS1='$ ' ;;
esac

# command splitting into multiple lines
export PS2=">"

# 'select' menu
export PS3="#? "

# output tracing
export PS4="++ "
