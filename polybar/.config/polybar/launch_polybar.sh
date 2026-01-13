#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar for each monitor
if type "xrandr"; then
  MONITORS=$(xrandr --query | grep " connected" | cut -d" " -f1)
  COUNT=1
  for m in $MONITORS; do
    if [ $COUNT -eq 1 ]; then
      MONITOR=$m polybar --reload monitor1 -c ~/.config/polybar/config.ini &
    elif [ $COUNT -eq 2 ]; then
      MONITOR=$m polybar --reload monitor2 -c ~/.config/polybar/config.ini &
    elif [ $COUNT -eq 3 ]; then
      MONITOR=$m polybar --reload monitor3 -c ~/.config/polybar/config.ini &
    fi
    COUNT=$((COUNT + 1))
  done
else
  polybar --reload monitor1 -c ~/.config/polybar/config.ini &
fi

echo "Polybar launched..."
