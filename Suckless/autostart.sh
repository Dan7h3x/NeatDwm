#!/bin/bash

# Ultra simple autostart

start() {
    killall "$1" 2>/dev/null
    "$@" >/dev/null 2>&1 &
}


# System
# xrdb -merge ~/.cache/wal/colors.Xresources
feh --bg-scale ~/.config/Wallpaper/astro-jelly.jpg
# X settings
start xsetroot -cursor_name left_ptr
start setxkbmap us,ir -option 'grp:alt_shift_toggle'
# start xset r rate 200 50
# Apps
start mpd
start mpd-mpris
start picom
start dwmblocks
# start wired


