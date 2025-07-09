#!/usr/bin/bash
# power-profiles.sh

current=$(powerprofilesctl get)

if [[ $1 == "prev" ]]; then
	if [[ $current == "balanced" ]]; then
		powerprofilesctl set power-saver
	elif [[ $current == "performance" ]]; then
		powerprofilesctl set balanced
	elif [[ $current == "power-saver" ]]; then
		powerprofilesctl set performance
	fi
else
	if [[ $current == "balanced" ]]; then
		powerprofilesctl set performance
	elif [[ $current == "performance" ]]; then
		powerprofilesctl set power-saver
	elif [[ $current == "power-saver" ]]; then
		powerprofilesctl set balanced
	fi
fi
