#!/bin/bash

TAG_INDEX="$1"

if [ -z "$TAG_INDEX" ]; then
  echo ""
  exit 0
fi

# Get current monitor
MONITOR=$(mmsg get monitor "eDP-1" 2>/dev/null | jq -r '.name' 2>/dev/null)

if [ -z "$MONITOR" ] || [ "$MONITOR" = "null" ]; then
  MONITOR="default"
fi

# Get tag info
TAG_INFO=$(mmsg get tag "$MONITOR" "$TAG_INDEX" 2>/dev/null)

if [ -z "$TAG_INFO" ] || [ "$TAG_INFO" = "null" ]; then
  echo ""
  exit 0
fi

# Build class string
CLASS=""

OCCUPIED=$(echo "$TAG_INFO" | jq -r '.occupied // false')
FOCUSED=$(echo "$TAG_INFO" | jq -r '.focused // false')

[ "$OCCUPIED" = "true" ] && CLASS="occupied"
[ "$FOCUSED" = "true" ] && CLASS="$CLASS focused"

echo "$CLASS" | xargs
