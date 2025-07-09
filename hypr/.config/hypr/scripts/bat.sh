#!/usr/bin/bash
# Heavily inspired (partly ripped off) from Thunder-Blaze/BlazinLock blazinscripts.sh

# Get battery path
battery_path=$(find /sys/class/power_supply -name 'BAT*' | head -n 1)

# Get current battery percentage
battery_percentage=$(cat $battery_path/capacity)

# Get the battery status
battery_status=$(cat $battery_path/status)

# Define the battery icons for each 10% segment
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Define the charging icon
charging_icon="󰂄"

# Calculate the index for the icon array
icon_index=$((battery_percentage / 10))

# Get the corresponding icon
battery_icon=${battery_icons[icon_index]}

# Check if the battery is charging
if [ "$battery_status" = "Charging" ]; then
	battery_icon="$charging_icon"
fi

# Output the battery percentage and icon
echo "<span rise='+1500'>$battery_icon</span> $battery_percentage%"

