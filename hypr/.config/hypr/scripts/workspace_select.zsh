#!/usr/bin/zsh
# workspace_select.zsh

operation=$1
workspace=$2

result=$(hyprctl activeworkspace -j | jq --argjson WS $workspace '.monitorID * 6 + $WS')

if [[ $operation == "switch" ]]; then
    hyprctl dispatch workspace $result
fi

if [[ $operation == "move" ]]; then
    hyprctl dispatch movetoworkspace $result
fi

