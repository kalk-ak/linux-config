#!/bin/bash
LAUNCH_COMMAND="/opt/google/chrome/google-chrome --profile-directory=Default --app-id=mjoklplbddabcmpepnokjaffbmgbkkgg"


# Change these values:
APP_NAME="Git-hub"
WINDOW_CLASS="crx_mjoklplbddabcmpepnokjaffbmgbkkgg.Google-chrome"

# --- Pre-flight Check ---
# Ensure required tools are installed.
if ! command -v wmctrl &> /dev/null || ! command -v xdotool &> /dev/null; then
    echo "Error: This script requires 'wmctrl' and 'xdotool'."
    echo "Please install them using: sudo apt update && sudo apt install wmctrl && sudo apt install xdotool"
    exit 1
fi

# --- Main Logic ---
# Check if a window with the specified class exists.
# We use `grep` to find the window and `awk` to extract its hexadecimal ID.
APP_WINDOW_ID=$(wmctrl -lx | grep "$WINDOW_CLASS" | awk '{print $1}')

if [ -z "$APP_WINDOW_ID" ]; then
    # 1. NOT RUNNING: The window does not exist, so we launch the application.
    echo "$APP_NAME is not running, launching..."
    $LAUNCH_COMMAND &
else
    # The window exists. Now, check if it's the currently active window.
    ACTIVE_WINDOW_ID=$(xdotool getactivewindow)

    # Convert the hex ID from wmctrl to decimal for comparison with xdotool's output.
    APP_WINDOW_ID_DEC=$((APP_WINDOW_ID))

    if [ "$APP_WINDOW_ID_DEC" == "$ACTIVE_WINDOW_ID" ]; then
        # 3. CURRENTLY FOCUSED: The app is the active window, so we hide (minimize) it.
        echo "$APP_NAME is active, hiding window..."
        xdotool windowminimize "$ACTIVE_WINDOW_ID"
    else
        # 2. RUNNING BUT NOT FOCUSED: The app is running in the background, so we focus it.
        echo "$APP_NAME is running in the background, focusing window..."
        wmctrl -i -a "$APP_WINDOW_ID"
    fi
fi

