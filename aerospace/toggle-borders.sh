#!/bin/bash

count=$(aerospace list-windows --workspace focused 2>/dev/null | wc -l | tr -d ' ')

if [ "$count" -le 1 ]; then
  borders active_color=0x00000000 inactive_color=0x00000000 width=0.0
else
  borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=5.0
fi
