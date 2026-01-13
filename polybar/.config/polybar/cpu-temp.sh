#!/usr/bin/env bash
for d in /sys/class/hwmon/hwmon*; do
  for l in "$d"/temp*_label; do
    if [ -f "$l" ] && grep -q "Package id 0" "$l"; then
      f="${l/_label/_input}"
      if [ -f "$f" ]; then
        t=$(cat "$f")
        awk -v v="$t" 'BEGIN{printf "%.0f°C\n", v/1000}'
        exit 0
      fi
    fi
  done
done
echo "n/a"
exit 0

