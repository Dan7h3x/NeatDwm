#!/usr/bin/env zsh

# Directory containing the YAML files

# Command to be executed on the selected file

# Get the list of YAML files in the directory
files=$(ls ~/.config/keyb/*.yml 2> /dev/null)

# Display a rofi menu with the file names/icons as options
selected_file=$(echo $files | rofi -dmenu -i -theme ~/.config/rofi/rofi-network-manager.rasi -p "Select a Categori:")

# Execute the command on the selected file
if [ -n "$selected_file" ]; then
    keyb -k $selected_file -p | rofi -dmenu -theme ~/.config/rofi/rofi-network-manager.rasi
fi
