#!/bin/bash
NX_pos="$(xdotool getmouselocation --shell | awk -F '=' '/X/ {print $2}')"
X_pos=`expr 1380 - $NX_pos`
output="$(cat ~/.stuff/trayer.status)"
echo $output
if [ "$output" == "hidden" ]
then
  pkill -9 trayer
  trayer --edge top --align right --widthtype request --height 18 --tint 0x1c1c1c --transparent true --expand true --SetDockType true --alpha 0 --distancefrom left --margin $X_pos &
  echo "no-hidden" > ~/.stuff/trayer.status
else
  pkill -9 trayer
  trayer --edge right --align left --widthtype request --width 18 --tint 0x1c1c1c --transparent true --expand true --SetDockType true --alpha 0 --margin -200 &
  echo "hidden" > ~/.stuff/trayer.status
fi
