# - ## Recording
#
# This module provides scripts to control video and audio recording using FFmpeg.
#
# - `start-recording` initiates recording from the default webcam (/dev/video0) and audio source,
#   saving to ~/Videos with a timestamped filename. Logs are saved to ~/.recording.log.
# - `stop-recording` terminates the recording process, ensures graceful shutdown,
#   and logs actions to ~/.recording.log.
{pkgs, ...}: let
  start-recording = pkgs.writeShellScriptBin "start-recording" ''
    set -euo pipefail

    # Define variables
    OUTPUT_DIR="$HOME/Videos"
    LOG_FILE="$HOME/.recording.log"
    PID_FILE="$HOME/.ffmpeg.pid"
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    OUTPUT_FILE="$OUTPUT_DIR/recording_$TIMESTAMP.mp4"

    # Ensure output directory exists
    mkdir -p "$OUTPUT_DIR" || { echo "Failed to create $OUTPUT_DIR"; exit 1; }

    # Check if a recording is already running
    if [ -f "$PID_FILE" ]; then
      if ps -p "$(cat "$PID_FILE")" > /dev/null 2>&1; then
        echo "Error: A recording is already running (PID: $(cat "$PID_FILE"))"
        exit 1
      else
        rm -f "$PID_FILE"
      fi
    fi

    # Check if webcam and audio devices are available
    if [ ! -e /dev/video0 ]; then
      echo "Error: Webcam (/dev/video0) not found"
      exit 1
    fi
    if ! ${pkgs.pulseaudio}/bin/pactl info > /dev/null 2>&1; then
      echo "Error: PulseAudio not available"
      exit 1
    fi

    # Start FFmpeg recording
    echo "Starting recording to $OUTPUT_FILE" | tee -a "$LOG_FILE"
    ${pkgs.ffmpeg}/bin/ffmpeg \
      -f v4l2 \
      -i /dev/video0 \
      -f pulse \
      -i default \
      -c:v libx264 \
      -c:a aac \
      -y \
      "$OUTPUT_FILE" >> "$LOG_FILE" 2>&1 &
    FFMPEG_PID=$!

    # Verify FFmpeg started successfully
    sleep 1
    if ! ps -p "$FFMPEG_PID" > /dev/null 2>&1; then
      echo "Error: Failed to start recording. Check $LOG_FILE for details"
      exit 1
    fi

    # Save PID
    echo "$FFMPEG_PID" > "$PID_FILE"
    echo "Recording started (PID: $FFMPEG_PID). Output: $OUTPUT_FILE"
  '';
  stop-recording =
    pkgs.writeShellScriptBin "stop-recording"
    ''
      set -euo pipefail

      # Define variables
      PID_FILE="$HOME/.ffmpeg.pid"
      LOG_FILE="$HOME/.recording.log"

      # Check if recording is running
      if [ ! -f "$PID_FILE" ]; then
        echo "No recording process found"
        exit 0
      fi

      PID=$(cat "$PID_FILE")
      if ! ps -p "$PID" > /dev/null 2>&1; then
        echo "No active recording process found (stale PID file)"
        rm -f "$PID_FILE"
        exit 0
      fi

      # Stop recording
      echo "Stopping recording (PID: $PID)" | tee -a "$LOG_FILE"
      if kill -TERM "$PID" 2>/dev/null; then
        # Wait for FFmpeg to exit gracefully
        timeout=10
        while [ $timeout -gt 0 ] && ps -p "$PID" > /dev/null 2>&1; do
          sleep 1
          timeout=$((timeout - 1))
        done

        if ps -p "$PID" > /dev/null 2>&1; then
          echo "Recording did not stop gracefully, forcing termination" | tee -a "$LOG_FILE"
          kill -KILL "$PID" 2>/dev/null
        fi

        rm -f "$PID_FILE"
        echo "Recording stopped successfully"
      else
        echo "Error: Failed to stop recording. Check $LOG_FILE for details" | tee -a "$LOG_FILE"
        rm -f "$PID_FILE"
        exit 1
      fi
    '';
in {
  home.packages = [start-recording stop-recording pkgs.ffmpeg-full];
}
