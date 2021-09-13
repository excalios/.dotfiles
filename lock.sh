#!/bin/sh

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D='#b3a1e6cc'  # default
T='#686f9aee'  # text
CL='#7a5cccff'  # click
W='#e33400bb'  # wrong
V='#f2ce00bb'  # verifying

i3lock \
--insidever-color=$C   \
--ringver-color=$V     \
\
--insidewrong-color=$C \
--ringwrong-color=$W   \
\
--inside-color=$B      \
--ring-color=$D        \
--line-color=$B        \
--separator-color=$D   \
\
--verif-color=$T        \
--wrong-color=$T        \
--time-color=$T        \
--date-color=$T        \
--layout-color=$T      \
--keyhl-color=$CL       \
--bshl-color=$W        \
\
--blur 5              \
--clock               \
--indicator           \
