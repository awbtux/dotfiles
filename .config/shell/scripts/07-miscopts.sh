#!/bin/sh

# use wayland if needed
[ "$XDG_SESSION_TYPE" = "wayland" ] && export MOZ_ENABLE_WAYLAND="1"

# language
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export PYTHONIOENCODING="UTF-8"

# rc file locations
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/shell/pythonrc"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
export CURL_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/curl"
export GIMP2_DIRECTORY="${XDG_CONFIG_HOME:-$HOME/.config}/gimp"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch/config"
export MOST_INITFILE="${XDG_CONFIG_HOME:-$HOME/.config}/most/mostrc"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"

# colors
export GREP_COLOR="01;31"
export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"
export LSCOLORS="ExGxFxDxCxDxFxCxCxacaD"
export LS_COLORS="di=1;34:fi=0:ln=1;36:pi=1;33:so=1;35:bd=1;33:cd=1;33:or=1;31:mi=1;31:ex=1;32"
export TREE_COLORS="$LS_COLORS"

# groff stuff
export GROFF_BIN_PATH="$PATH"
export GROFF_ENCODING="UTF-8"
export GROFF_TMPDIR="${XDG_CACHE_HOME:-$HOME/.cache}/groff"
export GROFF_NO_SGR="1"

# mpv stuff
export MPV_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/mpv"
export MPV_LEAK_REPORT="1"
export DVDCSS_VERBOSE="1"

# soulseek-cli env vars
export SOULSEEK_ACCOUNT="$(tr -dc A-Za-z0-9 </dev/urandom | head -c7)"
export SOULSEEK_PASSWORD="$(tr -dc A-Za-z0-9 </dev/urandom | head -c24)"

# git config file
export GIT_CONFIG_GLOBAL="${XDG_CONFIG_HOME:-$HOME/.config}/gitconfig"

# transmission dir
export TRANSMISSION_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/transmission"

# elinks configuration directory
export ELINKS_CONFDIR="${XDG_CONFIG_HOME:-$HOME/.config}/elinks"

# fzf config
export FZF_DEFAULT_OPTS="--color=16 --extended"
export FZF_DEFAULT_COMMAND="find . -xdev"

# move xauthority out of ~, doesn't work with all display managers/desktops
case "$X_WM_USE" in
    '(placeholder)') export XAUTHORITY="$HOME/.Xauthority" ;;
    *) export XAUTHORITY="${XDG_DATA_HOME:-$HOME/.local/share}/xauthority" ;;
esac

# tmux temp dir
export TMUX_TMPDIR="${XDG_RUNTIME_DIR:-/run/user/${EUID:-${UID:-$(id -u)}}}"

# 'watch' update interval
export WATCH_INTERVAL="0.5"

# other misc. environment variables
export MOZ_USE_XINPUT2="2"
export QT_QPA_PLATFORMTHEME="gtk3"
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
export _JAVA_AWT_WM_NONREPARENTING="1"
