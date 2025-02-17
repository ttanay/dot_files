#!/usr/bin/env bash

# Pre-requisites:
# 1. sudo apt install wmctrl xdotool
# 2. sudo gem install wmctile


# Check if window is already viewable
WINDOW_VIEWABLE=$(xdotool getwindowfocus getwindowname | grep 'Zeal')
if [[ $WINDOW_VIEWABLE ]]
then
  wmctile --shade zeal
else
  wmctile --summon zeal --exec zeal
fi
