#!/usr/bin/env zsh

if [[ -n "$TMUX" ]]; then
  tmux new-window -n "notes" -c ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Personal nvim
else
  tmux new-session -s "notes" -c ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Personal nvim
fi
