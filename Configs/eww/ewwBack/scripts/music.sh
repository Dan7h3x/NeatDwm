#!/bin/bash

Players=$(playerctl -l 2>/dev/null)
current_player=""

for player in $Players ;do
  status=$(playerctl --player="$player" status 2>/dev/null)
  if [[ "$status" == "Playing" ]]; then
    current_player=$player
    break
  fi
done

if [[ $(playerctl metadata title) == "No players found" ]]; then
  systemctl --user  --now enable mpd-mpris
fi


case "$1" in
status)
  playerctl --player="$current_player" 2>/dev/null || echo "Stopped"
  ;;
title)
  playerctl --player="$current_player" metadata title 2>/dev/null || echo "No Title"
  ;;
artist)
  playerctl --player="$current_player" metadata artist 2>/dev/null || echo "No Artist"
  ;;
position)
  playerctl --player="$current_player" position 2>/dev/null | cut -d. -f1 || echo "0"
  ;;
duration)
  playerctl --player="$current_player" metadata mpris:length 2>/dev/null | awk '{print int($1/1000000)}' || echo "100"
  ;;
toggle)
  playerctl play-pause 2>/dev/null
  ;;
next)
  playerctl next 2>/dev/null
  ;;
prev)
  playerctl previous 2>/dev/null
  ;;
*)
  echo "Usage: $0 {status|title|artist|position|duration|toggle|next|prev}"
  exit 1
  ;;
esac
