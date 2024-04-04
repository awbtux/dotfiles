#!/bin/sh

# skip this script if gpg is disabled
case "$DISABLE_GNUPG" in
    [yY]|yes|1) return ;;
    *) ;;
esac

# move gnupg dir into ~/.local/share
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"

# move password store ~/.local/share
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"

# gpg terminal
export GPG_TTY="$(tty 2>/dev/null)"

# create the gnupg home dir
[ -d "${GNUPGHOME:-$HOME/.gnupg}" ] || mkdir -pm 700 "${GNUPGHOME:-$HOME/.gnupg}"

# soulseek-cli stuff
export SOULSEEK_ACCOUNT="$(tr -dc A-Za-z0-9 </dev/urandom 2>/dev/null | head -c7 2>/dev/null)"
export SOULSEEK_PASSWORD="$(tr -dc A-Za-z0-9 </dev/urandom 2>/dev/null | head -c24 2>/dev/null)"
