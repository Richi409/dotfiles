#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done


# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log

amount_of_displays=$(polybar --list-monitors | wc -l)

if [ $amount_of_displays -gt 1 ];
then
    for m in $(polybar --list-monitors | cut -d":" -f1);
    do
        if [ "${m}" -eq "HDMI-1" ];
        then
            MONITOR=$m polybar --reload main 2>&1 & 
        else
            MONITOR=$m polybar --reload secundary 2>&1 & 
        fi
    done

else
    MONITOR=$m polybar --reload main 2>&1 & 
fi

# polybar main 2>&1 | tee -a /tmp/main.log & disown
# polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Bars launched..."
