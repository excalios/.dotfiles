#!/bin/bash

killall -q polybar

while pgrep -x compton >/dev/null; do sleep 1; done

compton
