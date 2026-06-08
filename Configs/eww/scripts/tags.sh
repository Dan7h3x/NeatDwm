#!/bin/bash
# scripts/mango-tags.sh

mmsg watch all-tags | while read -r line; do
  echo "$line" | jq -r '
        .all_tags[0].tags
        | map(select(.client_count > 0 or .is_active == true))
        | map(
            "(button :class \"tag " +
            (if .is_active then "focused" else "occupied" end) +
            "\" :onclick \"mmsg dispatch view," + (.index | tostring) +
            "\" \"" + (.index | tostring) + "\")"
        ) | join(" ")
    ' | while read -r tags_widgets; do
    if [ -z "$tags_widgets" ] || [ "$tags_widgets" == "" ]; then
      echo "(box :orientation \"h\" (label :text \"--\"))"
    else
      echo "(box :class 'tag' :orientation \"h\" :space-evenly false $tags_widgets)"
    fi
  done
done
