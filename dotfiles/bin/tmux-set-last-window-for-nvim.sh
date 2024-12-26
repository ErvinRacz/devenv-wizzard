#!/bin/bash

# Get the current window ID from tmux
window_id=$(tmux display-message -p '#{window_id}')

# Write this window ID to a file in the temp folder
echo "$window_id" > /tmp/last_tmux_window_id
