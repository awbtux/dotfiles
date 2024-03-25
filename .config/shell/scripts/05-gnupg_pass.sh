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
command -v tty >/dev/null 2>&1 && export GPG_TTY="$(tty)"

# create the gnupg home dir
[ -d "${GNUPGHOME:-$HOME/.gnupg}" ] || mkdir -p "${GNUPGHOME:-$HOME/.gnupg}"

# change permissions for gnupg home if necessary
command -v stat chmod >/dev/null 2>&1 && {
    case "$(stat -c '%a' ${GNUPGHOME:-$HOME/.gnupg})" in
        *00) ;;
        *) chmod 700 ${GNUPGHOME:-$HOME/.gnupg} ;;
    esac
}

# set the GPG signing key
[ -r "${GNUPGHOME:-$HOME/.gnupg}/key.txt" ] && command -v head >/dev/null 2>&1 && {
    IFS="" read -r GPG_SIGNING_KEY <"${GNUPGHOME:-$HOME/.gnupg}/key.txt"
    export GPG_SIGNING_KEY
}
