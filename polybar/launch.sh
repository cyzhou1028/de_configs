if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload main &
    polybar --reload secondary &
  done
else
  polybar --reload main &
fi
