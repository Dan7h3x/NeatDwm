#!/bin/bash

# Theme selector for dwm using dmenu and JSON themes
# Save as: ~/.config/dwm/theme-selector.sh

THEME_DIR="$HOME/.config/dwm/themes"
THEME_FILE="$THEME_DIR/themes.json"
XRESOURCES_TEMP="/tmp/dwm-theme.Xresources"

# Create theme directory if it doesn't exist
mkdir -p "$THEME_DIR"

# Check if dmenu is installed
if ! command -v dmenu &> /dev/null; then
echo "Error: dmenu is not installed!"
exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
echo "Error: jq is not installed!"
echo "Install with: sudo apt install jq (or your package manager)"
exit 1
fi

# Create default themes.json if it doesn't exist
if [ ! -f "$THEME_FILE" ]; then
cat > "$THEME_FILE" << 'EOF'
{
  "themes": {
"dark": {
"normfgcolor": "#bbbbbb",
"normbgcolor": "#222222",
"normbordercolor": "#444444",
"normfloatcolor": "#333333",
"selfgcolor": "#eeeeee",
"selbgcolor": "#005577",
"selbordercolor": "#005577",
"selfloatcolor": "#005577",
"titlenormfgcolor": "#bbbbbb",
"titlenormbgcolor": "#222222",
"titlenormbordercolor": "#444444",
"titlenormfloatcolor": "#333333",
"titleselfgcolor": "#eeeeee",
"titleselbgcolor": "#005577",
"titleselbordercolor": "#005577",
"titleselfloatcolor": "#005577",
"tagsnormfgcolor": "#bbbbbb",
"tagsnormbgcolor": "#222222",
"tagsnormbordercolor": "#444444",
"tagsnormfloatcolor": "#333333",
"tagsselfgcolor": "#eeeeee",
"tagsselbgcolor": "#005577",
"tagsselbordercolor": "#005577",
"tagsselfloatcolor": "#005577",
"hidnormfgcolor": "#bbbbbb",
"hidnormbgcolor": "#222222",
"hidselfgcolor": "#eeeeee",
"hidselbgcolor": "#005577",
"urgfgcolor": "#ffffff",
"urgbgcolor": "#ff0000",
"urgbordercolor": "#ff0000",
"urgfloatcolor": "#ff0000",
"ltsymbolfgcolor": "#bbbbbb",
"ltsymbolbgcolor": "#222222"
},
"light": {
"normfgcolor": "#222222",
"normbgcolor": "#f0f0f0",
"normbordercolor": "#cccccc",
"normfloatcolor": "#dddddd",
"selfgcolor": "#ffffff",
"selbgcolor": "#3388cc",
"selbordercolor": "#3388cc",
"selfloatcolor": "#3388cc",
"titlenormfgcolor": "#222222",
"titlenormbgcolor": "#f0f0f0",
"titlenormbordercolor": "#cccccc",
"titlenormfloatcolor": "#dddddd",
"titleselfgcolor": "#ffffff",
"titleselbgcolor": "#3388cc",
"titleselbordercolor": "#3388cc",
"titleselfloatcolor": "#3388cc",
"tagsnormfgcolor": "#222222",
"tagsnormbgcolor": "#f0f0f0",
"tagsnormbordercolor": "#cccccc",
"tagsnormfloatcolor": "#dddddd",
"tagsselfgcolor": "#ffffff",
"tagsselbgcolor": "#3388cc",
"tagsselbordercolor": "#3388cc",
"tagsselfloatcolor": "#3388cc",
"hidnormfgcolor": "#222222",
"hidnormbgcolor": "#f0f0f0",
"hidselfgcolor": "#ffffff",
"hidselbgcolor": "#3388cc",
"urgfgcolor": "#ffffff",
"urgbgcolor": "#ff3333",
"urgbordercolor": "#ff3333",
"urgfloatcolor": "#ff3333",
"ltsymbolfgcolor": "#222222",
"ltsymbolbgcolor": "#f0f0f0"
}
  }
}
EOF
echo "Created default themes.json at $THEME_FILE"
fi

# Get list of themes from JSON
THEME_LIST=$(jq -r '.themes | keys[]' "$THEME_FILE" 2>/dev/null)

if [ -z "$THEME_LIST" ]; then
echo "Error: Could not read themes from $THEME_FILE"
exit 1
fi

# Use dmenu to select a theme
SELECTED_THEME=$(echo "$THEME_LIST" | dmenu -l 10 -p "Select theme:" -i)

if [ -z "$SELECTED_THEME" ]; then
echo "No theme selected"
exit 0
fi

# Generate Xresources content from selected theme
echo "! Generated from theme: $SELECTED_THEME" > "$XRESOURCES_TEMP"
echo "! Date: $(date)" >> "$XRESOURCES_TEMP"
echo "" >> "$XRESOURCES_TEMP"

# Extract all color values for the selected theme
jq -r --arg theme "$SELECTED_THEME" '
  .themes[$theme] | to_entries[] | "dwm." + .key + ": " + .value
' "$THEME_FILE" >> "$XRESOURCES_TEMP"

# Merge the new Xresources
xrdb -merge "$XRESOURCES_TEMP"

msg=$(dwm-msg run_command xrdb)
notify-send "Dwm" "Theme $SELECTED_THEME applied"


