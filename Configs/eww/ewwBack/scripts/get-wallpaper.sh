#!/usr/bin/env bash

directory="/home/kratos/.config/Wallpaper"

# Use full path for find (important for Eww)
FIND="/usr/bin/find"

# Start JSON
printf '{ "wallpapers": ['

first=true

while true ;do

    while IFS= read -r file; do
    if [ "$first" = true ]; then
        first=false
    else
        printf ','
    fi

    # Properly escape double quotes
    printf '"%s"' "$(printf '%s' "$file" | sed 's/"/\\"/g')"

    done < <($FIND "$directory" -type f \( -iname "*.jpg" -o -iname "*.png" \))

    printf '] }\n'
    sleep 120

done

