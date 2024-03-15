#!/bin/sh

# shell history file
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history/${SHNAME}_history"

# 4096 entries of command history
export HISTSIZE="4096"
export HISTFILESIZE="4096"
export SAVEHIST="4096"

# history time format
export HISTTIMEFORMAT="(%F %T) "

# ignore space-prepended commands and duplicates
export HISTCONTROL="ignoredups:ignorespace"

# sqlite history file
export SQLITE_HISTORY="${XDG_DATA_HOME:-$HOME/.local/share}/history/sqlite_history"

# less history file
export LESSHISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history/less_history"

# python history file
export PYTHON_HISTORY_FILE="${XDG_DATA_HOME:-$HOME/.local/share}/history/python_history"

# node repl history file
export NODE_REPL_HISTORY="${XDG_DATA_HOME:-$HOME/.local/share}/history/node_repl_history"
