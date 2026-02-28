#!/bin/bash
IDLE_FILE="/tmp/claude-idle-panes"
CURRENT_PANE=$(tmux display-message -p '#{pane_id}')

# Pop attention panes, skipping stale entries and the current pane
while [ -f "$IDLE_FILE" ] && [ -s "$IDLE_FILE" ]; do
  PANE_ID=$(head -1 "$IDLE_FILE")
  tmpfile=$(mktemp "${IDLE_FILE}.XXXXXX")
  tail -n +2 "$IDLE_FILE" > "$tmpfile" && mv "$tmpfile" "$IDLE_FILE" || rm -f "$tmpfile"

  # Skip if this is the pane we're already on
  [ "$PANE_ID" = "$CURRENT_PANE" ] && continue

  # Verify pane still exists
  if tmux display-message -t "$PANE_ID" -p '' 2>/dev/null; then
    tmux select-pane -t "$PANE_ID" 2>/dev/null
    tmux select-window -t "$PANE_ID" 2>/dev/null
    tmux switch-client -t "$PANE_ID" 2>/dev/null
    exit 0
  fi
done

# No attention panes — open fzf picker
tmux display-popup -E "$HOME/scripts/fzf_claude --inline"
