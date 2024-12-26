#!/bin/sh

# Check if one argument is passed
if [ $# -eq 1 ]; then
    selected=$1
else
    selected=$(find ~/Workspace -maxdepth 1 -type d -not -path '*/.*' | fzf)
fi

# Ensure a selection was made
if [ -z "$selected" ]; then
    exit 0
fi

# Generate a valid session name
selected_name=$(basename "$selected" | sed 's/\./_/g')

# Check if tmux is running
tmux_running=$(pgrep tmux)

# Start a new tmux session if no tmux session is active
if [ -z "$TMUX" ] && [ -z "$tmux_running" ]; then
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
fi

# Create a new tmux session if it doesn't already exist
if ! tmux has-session -t="$selected_name" 2>/dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

# Switch to the session
tmux switch-client -t "$selected_name"
