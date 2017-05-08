#!/bin/bash
case "$1" in
  "+")
    xbacklight + 5%;;
  "-")
    xbacklight - 5%;;
esac

echo ☀ $(xbacklight|awk '{print int($1)}')% | dzen2 -p 1 -w 150 -h 30 -x 1211 -y 25

