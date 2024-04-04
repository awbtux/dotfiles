#!/bin/sh

# set up the runtime dir if needed
test -d "${XDG_RUNTIME_DIR:=/tmp/runtime/${EUID:-${UID:-$(id -u)}}}" || mkdir -pm 0700 "$XDG_RUNTIME_DIR"
export XDG_RUNTIME_DIR

# other xdg base directories
export XDG_TEMPLATES_DIR="$HOME/template"
export XDG_PUBLICSHARE_DIR="$HOME/pub"
export XDG_DOCUMENTS_DIR="$HOME/docs"
export XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DOWNLOAD_DIR="$HOME/dl"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pics"
export XDG_VIDEOS_DIR="$HOME/vids"

# language
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export PYTHONIOENCODING="UTF-8"

# session type, can be 'x11' or 'wayland'
export XDG_SESSION_TYPE="wayland"

# specify the window manager to be launched by xinitrc
export X_WM_USE="dwm"

# some DEs require this to be ~/.Xauthority
export XAUTHORITY="${XDG_CACHE_HOME:-$HOME/.cache}/xauthority"

# set to 'y' to disable gnupg in this setup
export DISABLE_GNUPG="n"

# history files
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history/${SHNAME}_history"
export SQLITE_HISTORY="${XDG_DATA_HOME:-$HOME/.local/share}/history/sqlite_history"
export LESSHISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history/less_history"
export PYTHON_HISTORY_FILE="${XDG_DATA_HOME:-$HOME/.local/share}/history/python_history"
export NODE_REPL_HISTORY="${XDG_DATA_HOME:-$HOME/.local/share}/history/node_repl_history"

# rc file locations
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/shell/pythonrc"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch/config"
export MOST_INITFILE="${XDG_CONFIG_HOME:-$HOME/.config}/most/mostrc"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export GIT_CONFIG_GLOBAL="${XDG_CONFIG_HOME:-$HOME/.config}/gitconfig"

# other program paths/directories
export GIMP2_DIRECTORY="${XDG_CONFIG_HOME:-$HOME/.config}/gimp"
export CURL_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/curl"
export MPV_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/mpv"
export GROFF_TMPDIR="${XDG_CACHE_HOME:-$HOME/.cache}/groff"
export TRANSMISSION_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/transmission"
export ELINKS_CONFDIR="${XDG_CONFIG_HOME:-$HOME/.config}/elinks"
export TMUX_TMPDIR="${XDG_RUNTIME_DIR:-/run/user/${EUID:-${UID:-$(id -u)}}}"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/shell"
export GROFF_BIN_PATH="$PATH"
