#!/usr/bin/env zsh

source ~/.zshrc

PROJECTS_DIR="$HOME/dev"
directories=$(z -l "$PROJECTS_DIR" | awk '{print $2}')

git_projects=()
while IFS= read -r dir; do
    # Remove any surrounding whitespace
    dir=${dir##+([[:space:]])}
    dir=${dir%%+([[:space:]])}

    if [[ -d "$dir/.git" ]]; then
        git_projects+=("$dir")
    else
    fi
done <<< "$directories"


# Use fzf to select a project
selected=$(printf '%s\n' "${git_projects[@]}" | fzf --prompt="Select a project: ")

if [[ -n "$selected" ]]; then
    if [[ -n "$TMUX" ]]; then
      tmux new-window -n $(basename "$selected") -c $selected
    else
      tmux new-session -s  $(basename "$selected") -c $selected
    fi
else
    echo "No project selected."
fi

