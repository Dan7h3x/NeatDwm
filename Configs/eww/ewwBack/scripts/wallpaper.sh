#!/bin/bash

WALLPAPER_DIR="$HOME/.config/Wallpaper/"
CURRENT_FILE="$HOME/.config/eww/current_wallpaper"

# Create wallpaper directory if it doesn't exist
mkdir -p "$WALLPAPER_DIR"

# Initialize current wallpaper file
if [ ! -f "$CURRENT_FILE" ]; then
  echo "none" >"$CURRENT_FILE"
fi

case "$1" in
list)
  # List all wallpapers in JSON array format
  if [ -d "$WALLPAPER_DIR" ]; then
    find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
      -exec basename {} \; | jq -R -s -c 'split("\n") | map(select(length > 0))'
  else
    echo '[]'
  fi
  ;;
current)
  cat "$CURRENT_FILE"
  ;;
set)
  WALLPAPER="$2"
  if [ -z "$WALLPAPER" ]; then
    exit 1
  fi
  FULL_PATH="$WALLPAPER_DIR/$WALLPAPER"
  if [ -f "$FULL_PATH" ]; then
    # Set wallpaper using awww command
    awww img "$FULL_PATH" 2>/dev/null
    # Save current wallpaper
    echo "$WALLPAPER" >"$CURRENT_FILE"
  fi
  ;;
*)
  echo "Usage: $0 {list|current|set} [wallpaper]"
  exit 1
  ;;
esac
