#!/bin/sh

# skip this script if gpg or pass are not installed
for i in pass gpg
    do command -v "$i" >/dev/null 2>&1 || return 1
done

# skip this script if gpg is disabled
case "$DISABLE_GNUPG" in
    [yY]|yes|1) return ;;
    *) ;;
esac

# check if gpg already exists
[ -r "${GNUPGHOME:-$HOME/.gnupg}/pubring.kbx" ] || {
    printf "\n\033[1mNo GnuPG keys found. Run \`\033[22mgpg --full-gen-key\033[1m\` or set DISABLE_GNUPG=y to disable this message.\033[22m\n"
    return 1
}

# check if password store already exists
[ -r "${PASSWORD_STORE_DIR:-$HOME/.password-store}/.gpg-id" ] || {
    printf "\n\033[1mNo password store found. Run \`\033[22mpass init [GPG_ID]\033[1m\` or set DISABLE_GNUPG=y to disable this message.\033[22m\n"
    return 1
}
