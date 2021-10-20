#!/bin/bash

while pgrep -x compton >/dev/null; do sleep 1; done

compton
