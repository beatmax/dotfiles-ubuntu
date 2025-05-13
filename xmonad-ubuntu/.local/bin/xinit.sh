#!/bin/bash

sleep 1

# Merge in X11 settings.
[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME $HOME/.Xresources

resolution=$(xdpyinfo | awk '/dimensions/{print $2}')
[[ -f $HOME/.Xresources-$resolution ]] && xrdb -merge -I$HOME $HOME/.Xresources-$resolution

tries=5
while ! nitrogen --restore && ((--tries)); do
  echo "nitrogen --restore failed..."
  sleep 1
done

xcompmgr -c &

# keyboard layout, compose key combinations, etc:
# https://dry.sailingissues.com/us-international-keyboard-layout.html
# TODO setxkbmap -option esperanto:qwerty -option compose:menu
