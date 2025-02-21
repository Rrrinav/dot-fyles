#!/bin/bash

# Define output directory
OUTPUT_DIR=~/Videos/Screencast
mkdir -p "$OUTPUT_DIR"  # Ensure the directory exists

# If an argument is given, use it as the filename; otherwise, use a timestamped name
if [ -n "$1" ]; then
    OUTPUT_FILE="$OUTPUT_DIR/$1.mp4"
else
    OUTPUT_FILE="$OUTPUT_DIR/screencast-$(date +'%Y-%m-%d_%H-%M-%S').mp4"
fi

# Check if wf-recorder is running
if pgrep -x "wf-recorder" > /dev/null; then
    # If running, stop the recording
    pkill -SIGINT wf-recorder
    echo "Recording stopped."
else
    # If not running, start a new recording
    wf-recorder -g "$(slurp)" -f "$OUTPUT_FILE"
    echo "Recording started: $OUTPUT_FILE"
fi
