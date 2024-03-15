#!/bin/sh

# most POSIX-compliant shells don't support prompt expansion, but we can
# do this ourselves by executing this function
set_ps1() {
    case "${EUID:-${UID:-$(id -u)}}" in
        0) PS1="$(pathabbrev "$PWD")# " ;;
        *) PS1="$(pathabbrev "$PWD")$ " ;;
    esac
}

# set the prompt using the function
set_ps1

# change the behavior of cd, pushd, and popd to run the 'set_ps1' function
# whenever the working directory is changed
for i in cd pushd popd; do
    eval "_$i() { unalias $i; $i \$@; set_ps1; alias $i=_$i; }; alias $i=_$i"
done
