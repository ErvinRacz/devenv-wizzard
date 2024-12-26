#!/usr/bin/env bash

tmux list-panes -a -F '#{session_id} #{window_id} #{pane_current_command}' | awk '$1 == "'$(tmux display-message -p '#{session_id}')'" && $3 == "nvim" { print $2 }'
