#!/usr/bin/zsh
# hyprland monitor select

monitors=$(hyprctl monitors)

# Is home?
if [[ $(echo "$monitors" | grep "Samsung Electric Company S27C36x H4PW501759") ]]; then
    ln -sf ~/.config/hypr/layouts/home.conf ~/.tmp/current_monitor_layout.conf
# Is work?
# elif [[ $(echo "$monitors" | grep "") ]]; then
#     cp ~/.config/hypr/layouts/work.conf ~/.tmp/current_monitor_layout.conf
fi
