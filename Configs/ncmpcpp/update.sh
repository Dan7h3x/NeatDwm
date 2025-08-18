#!/usr/bin/env sh

pkill -RTMIN+3 dwmblocks
notify-send "$(mpc -f %file% | head -n1)"
