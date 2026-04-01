#!/bin/sh

handle() {
  case $1 in
    monitoradded*) xrandr --output DP-2 --primary ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
