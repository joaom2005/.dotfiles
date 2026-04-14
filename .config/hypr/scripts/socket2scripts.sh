#!/bin/sh

handle_monitor_added() {
  xrandr --output DP-2 --primary;
}

handle() {
  case $1 in
    monitoradded*) handle_monitor_added ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
