#!/usr/bin/bash
# waybar.sh

# If $DESKTOP is set
if [[ $DESKTOP == 1 ]]; then
	waybar -c ~/.config/waybar/desktop.jsonc & disown
	exit 0
fi

waybar -c ~/.config/waybar/laptop.jsonc & disown
