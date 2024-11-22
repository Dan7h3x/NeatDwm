#!/bin/bash
CURRENT_SONG="$(mpc current -f '%file%')"
FAVORITES_PLAYLIST="favorites"

if mpc playlist "$FAVORITES_PLAYLIST" | grep -q "^$CURRENT_SONG$"; then
    echo "true"
else
    echo "false"
fi 