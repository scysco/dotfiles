#!/bin/bash
output="$(cat ~/.stuff/trayer.status)"
if [ "$output" == "hidden" ]
then
  echo ◀
else
  echo ▶
fi
exit 0
