#!/bin/bash
echo ☀ $(xbacklight|awk '{print int($1)}')%
exit 0
