#!/bin/bash

while true; do
  song=$(mpc current -f "%title%")
  artist=$(mpc current -f "%artist%")
  volume=$(mpc volume | awk '{print $2}')
  playlists=$(mpc lsplaylists)

  eww update song="$song"
  eww update artist="$artist"
  eww update volume="$volume"
  eww update playlists="$playlists"

  sleep 1
done
