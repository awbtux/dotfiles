#!/bin/sh

# command dependencies
for i in uname head bc
    do command -v "$i" >/dev/null 2>&1 || return 1
done

# check the operating system name
case "$(uname -s)" in
    Linux) ;;
    *) return 1 ;;
esac

printf "\n\033[1mPower information:\033[22m\n"

# for each battery
for i in /sys/class/power_supply/BAT*; do
    test -r "$i" || continue
    b_mfr="$(cat $i/manufacturer 2>/dev/null)"
    b_model="$(cat $i/model_name 2>/dev/null)"
    b_perc="$(cat $i/capacity 2>/dev/null)"
    b_status="$(cat $i/status 2>/dev/null)"
    b_cc="$(cat $i/cycle_count 2>/dev/null)"
    b_energy_design="$(cat $i/energy_full_design 2>/dev/null)"
    b_energy_full="$(cat $i/energy_full 2>/dev/null)"
    b_energy_now="$(cat $i/energy_now 2>/dev/null)"
    b_power_now="$(cat $i/power_now 2>/dev/null)"
    b_volt_min="$(cat $i/voltage_min_design 2>/dev/null)"
    b_volt_now="$(cat $i/voltage_now 2>/dev/null)"
    b_decperc="$(printf "( $b_energy_now * 100 ) / $b_energy_full\n" | bc -ql 2>/dev/null)"
    b_decperc="$(printf "${b_decperc##*.}" | head -c 1 2>/dev/null)"
    b_wh_full="$(printf "$b_energy_full / 1000000\n" | bc -ql 2>/dev/null)"
    b_wh_design="$(printf "$b_energy_design / 1000000\n" | bc -ql 2>/dev/null)"
    b_wh_perc="$(printf "( $b_energy_full / $b_energy_design ) * 100\n" | bc -ql 2>/dev/null)"
    b_wh_decperc="$(printf "${b_wh_perc##*.}" | head -c 1 2>/dev/null)"
    b_wh_perc="${b_wh_perc%%.*}"
    b_wh_full_dec="$(printf "${b_wh_full##*.}" | head -c 1 2>/dev/null)"
    b_wh_design_dec="$(printf "${b_wh_design##*.}" | head -c 1 2>/dev/null)"
    b_wh_full="${b_wh_full%%.*}"
    b_wh_design="${b_wh_design%%.*}"

    # remaining time depending on status
    case "$b_status" in
        Discharging)
            b_rmng="$(printf "$b_energy_now / $b_volt_now\n" | bc -ql 2>/dev/null)"
            b_rmng_mins="$(printf "0.${b_rmng##*.} * 60\n" | bc -ql 2>/dev/null)"
            b_rmng="${b_rmng%%.*}"
            b_rmng_mins="${b_rmng_mins%%.*}"
            test -z "$b_rmng_mins" && b_rmng_mins="0"
            b_rmng_prefix="discharging"
            b_rmng_suffix="left"
            ;;
        Charging)
            b_rmng="$(printf "( $b_energy_full - $b_energy_now ) / $b_power_now\n" | bc -ql 2>/dev/null)"
            b_rmng_mins="$(printf "0.${b_rmng##*.} * 60\n" | bc -ql 2>/dev/null)"
            b_rmng="${b_rmng%%.*}"
            b_rmng_mins="${b_rmng_mins%%.*}"
            test -z "$b_rmng_mins" && b_rmng_mins="0"
            b_rmng_prefix="charging"
            b_rmng_suffix="left"
            ;;
        'Not charging')
            ;;
    esac

    # decide the percentage color
    test "$b_perc" -ge 0 && b_usecol="\033[31m"
    test "$b_perc" -gt 20 && b_usecol="\033[33m"
    test "$b_perc" -gt 49 && b_usecol="\033[32m"

    # battery name
    printf "  $b_mfr $b_model (${i##*/}):\n"

    # battery percentage
    printf "    \033[1mCapacity: ${b_usecol}$b_perc.$b_decperc%%\033[39m"

    # battery remaining
    printf "${b_rmng_prefix:+ ($b_rmng_prefix, }${b_rmng:+${b_rmng}h }${b_rmng_mins:+${b_rmng_mins}m $b_rmng_suffix)}\033[22m;\n"

    # decide the percentage color
    test "$b_wh_perc" -ge 0 && b_usecol="\033[31m"
    test "$b_wh_perc" -gt 30 && b_usecol="\033[33m"
    test "$b_wh_perc" -gt 60 && b_usecol="\033[32m"

    # battery health
    printf "    \033[1mHealth: ${b_usecol}${b_wh_perc}.${b_wh_decperc}%%\033[39m (${b_wh_full}${b_wh_full_dec:+.$b_wh_full_dec}Wh/${b_wh_design}${b_wh_design_dec:+.$b_wh_design_dec}Wh, cycle $b_cc)\033[22m;\n"

    # clean variables
    for cvar in b_mfr b_rmng_suffix b_wh_perc b_wh_full b_wh_design b_wh_decperc b_wh_full_dec b_wh_design_dec b_model b_perc b_usecol b_decperc b_status b_cc b_energy_design b_energy_full b_energy_now b_power_now b_volt_min b_volt_now b_rmng b_rmng_mins; do
        eval "$cvar="
    done
done
