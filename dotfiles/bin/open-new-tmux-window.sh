#!/usr/bin/env bash

# create a new window
# $1 - name of the window
# $2 - script / location of the script

tmux display-popup -T $1 -E "sh $2" 
