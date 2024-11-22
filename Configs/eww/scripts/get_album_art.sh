#!/bin/bash
MUSIC_DIR="$HOME/Music"
COVER="/tmp/cover.jpg"

# Get current song's directory
SONG_DIR="$(mpc --format %file% current | sed 's/[^/]*$//')"
FULL_DIR="${MUSIC_DIR}/${SONG_DIR}"

# Look for cover art
find "$FULL_DIR" -maxdepth 1 -type f | grep -i "\(folder\|cover\|front\).*\.\(jpg\|png\|gif\|bmp\)" | head -n 1 >"$COVER"

if [ ! -s "$COVER" ]; then
  echo "/path/to/default/cover.jpg"
else
  cat "$COVER"
fi
