#!/bin/bash

TODO_FILE="$HOME/.config/eww/todos.json"

# Initialize if doesn't exist
if [ ! -f "$TODO_FILE" ]; then
  echo '[]' >"$TODO_FILE"
fi

case "$1" in
list)
  cat "$TODO_FILE"
  ;;
add)
  TEXT="$2"
  if [ -z "$TEXT" ]; then
    exit 1
  fi
  ID=$(date +%s%N)
  jq --arg id "$ID" --arg text "$TEXT" \
    '. += [{"id": $id, "text": $text, "done": false}]' \
    "$TODO_FILE" >"$TODO_FILE.tmp" && mv "$TODO_FILE.tmp" "$TODO_FILE"
  ;;
toggle)
  ID="$2"
  jq --arg id "$ID" \
    'map(if .id == $id then .done = (.done | not) else . end)' \
    "$TODO_FILE" >"$TODO_FILE.tmp" && mv "$TODO_FILE.tmp" "$TODO_FILE"
  ;;
delete)
  ID="$2"
  jq --arg id "$ID" 'map(select(.id != $id))' \
    "$TODO_FILE" >"$TODO_FILE.tmp" && mv "$TODO_FILE.tmp" "$TODO_FILE"
  ;;
*)
  echo "Usage: $0 {list|add|toggle|delete} [args]"
  exit 1
  ;;
esac
