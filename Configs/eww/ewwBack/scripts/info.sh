#!/bin/bash

# CPU Usage
CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
CPU_ICON=""

# Memory Usage
MEM=$(free -m | awk 'NR==2{printf "%.0f", $3*100/$2}')
MEM_ICON=""

# Battery (if available)
if [ -d "/sys/class/power_supply/BAT1" ]; then
  BAT=$(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null || echo "0")
  BAT_STATUS=$(cat /sys/class/power_supply/BAT1/status 2>/dev/null || echo "Unknown")

  if [ "$BAT_STATUS" = "Charging" ]; then
    BAT_ICON=""
  elif [ "$BAT" -gt 80 ]; then
    BAT_ICON=""
  elif [ "$BAT" -gt 60 ]; then
    BAT_ICON=""
  elif [ "$BAT" -gt 40 ]; then
    BAT_ICON=""
  elif [ "$BAT" -gt 20 ]; then
    BAT_ICON=""
  else
    BAT_ICON=""
  fi

  echo "$CPU_ICON ${CPU}%  $MEM_ICON ${MEM}%  $BAT_ICON ${BAT}%"
else
  echo "$CPU_ICON ${CPU}%  $MEM_ICON ${MEM}%"
fi
