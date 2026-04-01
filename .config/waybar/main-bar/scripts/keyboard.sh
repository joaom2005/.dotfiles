#!/usr/bin/env bash

# Get current input method
current=$(fcitx5-remote -n)

case "$current" in
    *"keyboard-pt"*)
        echo "🇵🇹"
        ;;
    *"keyboard-us"*)
        echo "🇺🇸"
        ;;
    *"mozc"*|*"anthy"*|*"jp"*)
        echo "🇯🇵"
        ;;
    *)
        echo "⌨️"
        ;;
esac
