#!/bin/sh

# use wayland if needed
[ "$XDG_SESSION_TYPE" = "wayland" ] && export MOZ_ENABLE_WAYLAND="1"

# browser homepage
export WWW_HOME="https://lite.duckduckgo.com"

# shell history configuration
export HISTSIZE="4096"
export HISTFILESIZE="4096"
export SAVEHIST="4096"
export HISTTIMEFORMAT="(%F %T) "
export HISTCONTROL="ignoredups:ignorespace"

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

# fzf config
export FZF_DEFAULT_OPTS="--color=16 --extended"
export FZF_DEFAULT_COMMAND="find . -xdev"

# 'watch' update interval
export WATCH_INTERVAL="0.5"

# other misc. environment variables
export MOZ_USE_XINPUT2="2"
export QT_QPA_PLATFORMTHEME="gtk3"
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
export _JAVA_AWT_WM_NONREPARENTING="1"

# options for less
export LESS="-# 4 -s -R -M +Gg"
export LESS_TERMCAP_mb="[33m"
export LESS_TERMCAP_md="[32m"
export LESS_TERMCAP_me="[0m"
export LESS_TERMCAP_us="[1;34m"
export LESS_TERMCAP_ue="[22;39m"
export LESS_TERMCAP_so="[1;31m"
export LESS_TERMCAP_se="[22;39m"
