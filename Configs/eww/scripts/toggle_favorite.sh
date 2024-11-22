#!/bin/bash
CURRENT_SONG="$(mpc current -f '%file%')"
FAVORITES_PLAYLIST="favorites"

if mpc playlist "$FAVORITES_PLAYLIST" | grep -q "^$CURRENT_SONG$"; then
    mpc del "$FAVORITES_PLAYLIST" "$CURRENT_SONG"
else
    mpc add "$CURRENT_SONG" "$FAVORITES_PLAYLIST"
fi 