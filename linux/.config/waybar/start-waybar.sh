#!/usr/bin/env sh

# test if waybar is running
if pgrep -x "waybar" > /dev/null; then
    
    # kill waybar process
    pkill -x "waybar"

    # wait for process to be dead
    while pgrep -x waybar >/dev/null; do 
        sleep 1
    done
fi

if [ "${DESKTOP_SESSION}" = "niri" ]; then
    waybar -b 0 -c ~/.config/waybar/niri_config.jsonc -s ~/.config/waybar/style.css >/dev/null 2>&1 &
elif [ "${DESKTOP_SESSION}" = "sway" ]; then
    waybar -b 0 -c ~/.config/waybar/sway_config.jsonc -s ~/.config/waybar/style.css >/dev/null 2>&1 &
else
    waybar -b 0 -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css >/dev/null 2>&1 &
fi

# Launch waybar
# waybar -b 0 -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css >/dev/null 2>&1 &
# waybar -b 0 -c ~/.config/waybar/bars/sway/config.jsonc -s ~/.config/waybar/bars/sway/style.css >/dev/null 2>&1 &
