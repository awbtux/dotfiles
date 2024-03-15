#!/bin/sh

# create .hushlogin
:>$HOME/.hushlogin

# create XDG directories
mkdir -p \
    ${XDG_CONFIG_HOME:-$HOME/.config} \
    ${XDG_DATA_HOME:-$HOME/.local/share} \
    ${XDG_CACHE_HOME:-$HOME/.cache} \
    ${XDG_DESKTOP_DIR:-$HOME/Desktop} \
    ${XDG_DOCUMENTS_DIR:-$HOME/Documents} \
    ${XDG_DOWNLOAD_DIR:-$HOME/Downloads} \
    ${XDG_MUSIC_DIR:-$HOME/Music} \
    ${XDG_PICTURES_DIR:-$HOME/Pictures} \
    ${XDG_VIDEOS_DIR:-$HOME/Videos}
