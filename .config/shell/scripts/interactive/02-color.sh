#!/bin/sh

# standard (but better) console colors
case "$TERM" in
    linux)
        printf "\033]P0%s\033]P1%s\033]P2%s\033]P3%s\033]P4%s\033]P5%s\033]P6%s\033]P7%s\033]P8%s\033]P9%s\033]PA%s\033]PB%s\033]PC%s\033]PD%s\033]PE%s\033]PF%s" \
        "000000" \
        "ce3023" \
        "2c7032" \
        "c68b38" \
        "2265b9" \
        "9360a1" \
        "7daac3" \
        "a2a2a2" \
        "4a4a4a" \
        "e43627" \
        "40a349" \
        "ffc068" \
        "397cd0" \
        "dd91f3" \
        "93aee5" \
        "ffffff"
        #"100c0c" \
        #"905443" \
        #"7e8854" \
        #"bf7143" \
        #"5b6c6c" \
        #"90696b" \
        #"838e76" \
        #"b3a481" \
        #"4a3637" \
        #"bd6e58" \
        #"98a451" \
        #"db8553" \
        #"819858" \
        #"ae7f81" \
        #"a2b092" \
        #"dbca9f"
        ;;
esac
