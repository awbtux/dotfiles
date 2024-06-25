#!/bin/sh

# alsa hardware input/output PCMs; hw:0,0 selects the system's sound card and usually works for both
#export ALSA_INPUT_PCM="hw:0,0"
#export ALSA_OUTPUT_PCM="hw:0,0"

# plugins to use for alsa input/output; use equalizer if available, dmixer/dsnoop if not
test -n "$(find /lib*/alsa*/ /usr/lib*/alsa*/ /usr/local/lib*/alsa*/ -type f -regex ".*/libasound_module_[pc][ct][ml]_equal.so" 2>/dev/null)" && \
export ALSA_INPUT_PLUGIN="eq-in" ALSA_OUTPUT_PLUGIN="eq" || \
export ALSA_INPUT_PLUGIN="mixin" ALSA_OUTPUT_PLUGIN="dmixer"

# browser homepage
export WWW_HOME="https://lite.duckduckgo.com"

# shell history configuration
export HISTRMDUP="1"
export HISTSIZE="4096"
export HISTFILESIZE="4096"
export SAVEHIST="4096"
export HISTTIMEFORMAT="(%F %T) "
export HISTCONTROL="ignoredups:ignorespace"

# set the shell's visual line editor
export FCEDIT="$EDITOR"

# color configuration for commands
export GREP_COLOR="01;31"
export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"
export LSCOLORS="ExGxFxDxCxDxFxCxCxacaD"
export LS_COLORS="di=1;34:fi=0:ln=1;36:pi=1;33:so=1;35:bd=1;33:cd=1;33:or=1;31:mi=1;31:ex=1;32"
export TREE_COLORS="$LS_COLORS"

# groff stuff
export GROFF_ENCODING="UTF-8"
export GROFF_NO_SGR="1"

# mpv stuff
export MPV_LEAK_REPORT="1"
export DVDCSS_VERBOSE="1"

# fzf stuff
export FZF_DEFAULT_OPTS="--color=16 --extended --walker=file,follow"
#export FZF_DEFAULT_COMMAND="find . -xdev"

# 'watch' update interval
export WATCH_INTERVAL="0.5"

# options for less
export LESS="-# 4 -s -R -M +Gg"
export LESS_TERMCAP_mb="$(printf "\033[33m")"
export LESS_TERMCAP_md="$(printf "\033[32m")"
export LESS_TERMCAP_me="$(printf "\033[0m")"
export LESS_TERMCAP_us="$(printf "\033[1;34m")"
export LESS_TERMCAP_ue="$(printf "\033[22;39m")"
export LESS_TERMCAP_so="$(printf "\033[1;31m")"
export LESS_TERMCAP_se="$(printf "\033[22;39m")"

# display/driver configuration type stuff
export GDK_BACKEND="$XDG_SESSION_TYPE"
export CLUTTER_BACKEND="$XDG_SESSION_TYPE"
export QT_QPA_PLATFORM="wayland;xcb"
export SDL_VIDEODRIVER="wayland,x11"
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
export GTK_CSD="0"
export MOZ_USE_XINPUT2="2"
export MOZ_ENABLE_WAYLAND="$(test "$XDG_SESSION_TYPE" = "wayland" && printf "1")"
export _JAVA_AWT_WM_NONREPARENTING="1"

# note: some DEs need this to be ~/.Xauthority or unset
export XAUTHORITY="${XDG_CACHE_HOME:-$HOME/.cache}/xauthority"
