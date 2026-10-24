#!/bin/bash

# Get current keymode
mmsg get keymode 2>/dev/null | jq -r '.' || echo "normal"
