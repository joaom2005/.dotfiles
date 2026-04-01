#!/usr/bin/env bash
# wait-for-monitors.sh
# Waits until a given number of monitors are active in Hyprland, then runs setup.
# Usage: ./wait-for-monitors.sh

# ─── CONFIG ───────────────────────────────────────────────────────────────────

EXPECTED_MONITORS=2     # How many monitors to wait for
POLL_INTERVAL=0.5       # Seconds between checks
TIMEOUT=30              # Max seconds to wait before giving up

# ─── YOUR SETUP COMMANDS ──────────────────────────────────────────────────────
# Edit this function with whatever you want to run once both monitors are ready.

run_monitor_setup() {
    # Example: set monitor layout via hyprctl
    # hyprctl keyword monitor DP-1,1920x1080@144,0x0,1
    # hyprctl keyword monitor HDMI-A-1,1920x1080@60,1920x0,1

    # Example: set wallpapers with swww
    # swww img --outputs DP-1 ~/wallpapers/main.jpg
    # swww img --outputs HDMI-A-1 ~/wallpapers/second.jpg

    # Example: set a monitor as "primary" workspace anchor
    # hyprctl dispatch moveworkspacetomonitor 1 DP-1

    echo "[wait-for-monitors] Both monitors ready. Running setup..."

    # --- PUT YOUR COMMANDS BELOW ---
    
    waypaper --restore
    xrandr --output DP-2 --primary

    # --- END OF YOUR COMMANDS ---

    echo "[wait-for-monitors] Setup complete."
}

# ─── WAIT LOOP ────────────────────────────────────────────────────────────────

echo "[wait-for-monitors] Waiting for $EXPECTED_MONITORS monitors..."

elapsed=0
while true; do
    # Count monitors currently reported by Hyprland
    monitor_count=$(hyprctl monitors -j 2>/dev/null | python3 -c "import sys,json; print(len(json.load(sys.stdin)))" 2>/dev/null)

    if [[ "$monitor_count" =~ ^[0-9]+$ ]] && (( monitor_count >= EXPECTED_MONITORS )); then
        echo "[wait-for-monitors] Detected $monitor_count monitor(s). Proceeding."
        run_monitor_setup
        exit 0
    fi

    if (( elapsed >= TIMEOUT )); then
        echo "[wait-for-monitors] Timed out after ${TIMEOUT}s. Only $monitor_count monitor(s) found. Running setup anyway." >&2
        run_monitor_setup
        exit 1
    fi

    sleep "$POLL_INTERVAL"
    elapsed=$(echo "$elapsed + $POLL_INTERVAL" | bc)
done
