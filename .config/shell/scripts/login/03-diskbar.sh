#!/bin/sh

# command dependencies
for i in df awk wc; do
    command -v "$i" >/dev/null 2>&1 || return 1
done

# initialize these
for i in disks barlen disknamelen diskperclen total used avail perc mount barusage from; do
    unset "$i"
done

# set columns if needed
: "${COLUMNS:=$(tput cols 2>/dev/null)}"
: "${COLUMNS:=$(stty size 2>/dev/null | awk '{print $2}')}"

# bar size
barlen="$((COLUMNS/5))"

# get disks
disks="$(df | awk 'NR>1 {print $1}' | awk '/\/dev\//')"

# determine how much space to pad fields
for i in $(printf "$disks"); do
    # get percentage of disk used
    perc="$(df "$i" 2>/dev/null | awk 'NR>1 {print $5}' | awk -F'%' '{print $1}')"

    # length of disk name
    test "$(printf "$i" | wc -c)" -gt ${disknamelen:-0} && disknamelen="$(printf "$i" | wc -c)"

    # length of disk percentage
    test "$(printf "$perc" | wc -c)" -gt ${diskperclen:-0} && diskperclen="$(printf "$perc" | wc -c)"
done

# heading
printf "\n\033[1mMounted devices:\033[22m\n"

# print the line
for i in $(printf "$disks"); do
    # check if the disk is accessible
    df -h "$i" >/dev/null 2>&1 || continue

    # get metrics
    total="$(df -h "$i" | awk 'NR>1 {print $2}')"
    used="$(df -h "$i" | awk 'NR>1 {print $3}')"
    avail="$(df -h "$i" | awk 'NR>1 {print $4}')"
    perc="$(df -h "$i" | awk 'NR>1 {print $5}' | awk -F'%' '{print $1}' || printf "0")"
    mount="$(df -h "$i" | awk 'NR>1 {print $6}')"

    # amount of cells to color in used
    barusage="$(((perc*barlen)/100))"

    # ensure at least 1 if >=1%
    test "$barusage" -le 1 && test "$perc" -gt 0 && barusage="1"

    # determine the used cell color
    test "$perc" -gt 0 && usedcol="\033[32m"
    test "$perc" -gt 66 && usedcol="\033[33m"
    test "$perc" -gt 89 && usedcol="\033[31m"

    # beginning label
    printf "%${disknamelen}s: \033[1m%${diskperclen}s%% [$usedcol" "$i" "$perc"

    # print colored (used) cells
    for j in $(seq 1 "$barusage"); do
        printf "="
    done

    # change the color to the unused dim color
    printf "\033[22;39m\033[2m"

    # increment barusage
    barusage="$((barusage+1))"

    # print dimmed (unused) cells
    for i in $(seq "$barusage" "$barlen"); do
        printf "="
    done

    # newline etc
    printf "\033[22m\033[1;39m] ${usedcol}%s\033[39m of \033[22m\033[2m%s\033[22;39m\033[1m (%s)\033[22m\n" "$used" "$total" "$mount"
done

# clear these
for i in disks barlen disknamelen diskperclen total used avail perc mount barusage from; do
    unset "$i"
done
