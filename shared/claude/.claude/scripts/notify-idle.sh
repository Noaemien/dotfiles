#!/bin/bash
INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd // "unknown"')
PROJECT=$(basename "$CWD")

IDLE_FILE="/tmp/claude-idle-panes"

# Walk up the process tree to find our tmux pane
find_tmux_pane() {
  local pid=$$
  while [ "$pid" -gt 1 ]; do
    local pane
    pane=$(tmux list-panes -a -F '#{pane_id} #{pane_pid}' 2>/dev/null | awk -v p="$pid" '$2 == p {print $1}')
    if [ -n "$pane" ]; then
      echo "$pane"
      return
    fi
    pid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
  done
}

PANE_ID=$(find_tmux_pane)
if [ -n "$PANE_ID" ]; then
  # Append to idle panes file if not already present
  touch "$IDLE_FILE"
  if ! grep -qxF "$PANE_ID" "$IDLE_FILE"; then
    echo "$PANE_ID" >> "$IDLE_FILE"
  fi
fi

osascript -e "display notification \"$PROJECT — Claude needs input\" with title \"Claude Code\"" &
afplay /System/Library/Sounds/Tink.aiff &
