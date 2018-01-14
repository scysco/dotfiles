#!/bin/bash
image="$(cat .fehbg | awk -F ' ' '/ / {print $3}' | sed -e 's/^.//' -e 's/.$//')"
info="$(convert $image -colors 4 histogram:- | identify -format %c - \
| awk -F ')' '/ / {print $2}' | awk -F ' ' '/ / {print $1}' > ~/.stuff/bg-colors.txt )"
