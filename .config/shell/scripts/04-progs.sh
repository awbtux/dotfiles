#!/bin/sh

# TODO:
#  - set filetype defaults more precisely (ex. separate djvu/epub/pdf readers)
#  - test the capabilities of programs (ex. zathura plugins) for filetype support
#  - search repositories of various distros for packages to support here
#  - separate x11 and wayland stuff

# choose the terminal emulator
for i in xterm urxvt aterm terminator kitty konsole gnome-terminal mate-terminal qterminal lxterminal wezterm roxterm st foot alacritty
    do command -v $i >/dev/null 2>&1 && export TERMINAL="$i"
done

# editor choice
for i in nano micro vi nvi vim.tiny vim.basic vim nvim
    do command -v $i >/dev/null 2>&1 && export EDITOR="$i"
done

# whether the editor has a GUI or operates in the terminal
export EDITOR_GUI="y"

# use the editor as a visual editor
export VISUAL="$EDITOR"

# pager / manpager
for i in more less
    do command -v $i >/dev/null 2>&1 && export PAGER="$i"
done
export MANPAGER="$PAGER"

# browser
for i in amfora w3m links lynx elinks links2
    do command -v $i >/dev/null 2>&1 && export BROWSER="xdg-terminal-exec $i"
done
[ -n "${WAYLAND_DISPLAY:-$DISPLAY}" ] && {
    for i in google-chrome chromium-browser chromium netsurf midori dillo eolie falkon iceweasel seamonkey mozilla firefox konqueror badwolf librewolf icecat
        do command -v $i >/dev/null 2>&1 && export BROWSER="$i"
    done
}

# video player/image viewer
for i in timg mpv
    do command -v $i >/dev/null 2>&1 && export VPLAYER="xdg-terminal-exec $i"
done
[ -n "${WAYLAND_DISPLAY:-$DISPLAY}" ] && {
    for i in rage-player ffplay vlc mplayer smplayer qmplay2 celluloid mpv
        do command -v $i >/dev/null 2>&1 && export VPLAYER="$i"
    done
}

# image viewer
for i in catimg timg fbida mpv fbpdf fbv tiv viu
    do command -v $i >/dev/null 2>&1 && export IMGVIEWER="xdg-terminal-exec $i"
done
[ -n "${WAYLAND_DISPLAY:-$DISPLAY}" ] && {
    for i in deepin-image-viewer aloadimage gthumb ahoviewer eom geeqie gpicview mirage lximage-qt viewnior phototonic gwenview celluloid mpv swayimg nomacs qview qimgv feh qiv vimiv pqiv imv sxiv nsxiv
        do command -v $i >/dev/null 2>&1 && export IMGVIEWER="$i"
    done
}

# pdf reader
for i in lesspdf fbv fbpdf
    do command -v $i >/dev/null 2>&1 && export READER="xdg-terminal-exec $i"
done
[ -n "${WAYLAND_DISPLAY:-$DISPLAY}" ] && {
    for i in gv sioyek atril xreader qpdfview lumina-pdf xpdf epdfview katarakt mupdf apvlv zathura
        do command -v $i >/dev/null 2>&1 && export READER="$i"
    done
}

# terminal file manager preferred in simple environments
for i in fff shfm ranger cfm clifm mc vifm lfm nnn lf
    do command -v $i >/dev/null 2>&1 && export FILEMGR="xdg-terminal-exec $i"
done
[ -n "${WAYLAND_DISPLAY:-$DISPLAY}" ] && [ -n "$XDG_CURRENT_DESKTOP" ] && {
    for i in nautilus caja rox xfe pcmanfm thunar nemo krusader dolphin qtfm
        do command -v $i >/dev/null 2>&1 && export FILEMGR="$i"
    done
}
