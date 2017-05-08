#!/bin/bash
case "$1" in
  "+")
    amixer -D pulse set Master 2%+;;
  "-")
    amixer -D pulse set Master 2%-;;
  "m")
    amixer -D pulse set Master toggle ;;
esac

echo \(\(•\)\) $(pamixer --get-volum)% | dzen2 -p 1 -w 150 -h 30 -x 1211 -y 25

