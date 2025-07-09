#!/usr/bin/bash
# get current layout
active_layout=$(hyprctl --instance 0 devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')

# set correct symlink
if [[ "$active_layout" == *"Dvorak"* ]]; then
	ln -sf ~/.config/hypr/binds/us_dvorak.conf ~/.tmp/current_layout.conf
elif [[ $active_layout == *"Danish"* ]]; then
	ln -sf ~/.config/hypr/binds/dk_qwerty.conf ~/.tmp/current_layout.conf
else
	ln -sf ~/.config/hypr/binds/us_qwerty.conf ~/.tmp/current_layout.conf
fi

# reload hypr config
hyprctl --instance 0 reload

