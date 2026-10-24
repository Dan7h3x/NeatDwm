#!/bin/bash

# Get focused client information
CLIENT=$(mmsg get focusing-client 2>/dev/null)

if [ -z "$CLIENT" ] || [ "$CLIENT" = "null" ]; then
  echo ""
  exit 0
fi

# Extract title
echo "$CLIENT" | jq -r '.title // .app_id // ""' | head -c 50
