#!/bin/bash
# Refreshes the cache of remote tmux panes running claude.
# Intended to be run periodically via launchd.

CACHE_FILE="/tmp/claude-remote-panes-cache"
HOSTS_FILE="${HOME}/.claude_remote_hosts"

[[ -f "$HOSTS_FILE" ]] || exit 0

tmpfile=$(mktemp "${CACHE_FILE}.XXXXXX")

pids=()
while IFS= read -r host; do
  [[ -z "$host" || "$host" == \#* ]] && continue
  (
    ssh -o ConnectTimeout=3 -o BatchMode=yes "$host" \
      'tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index} #{pane_pid} #{pane_current_path}" 2>/dev/null | while read -r pane pid path; do
        if pgrep -P "$pid" -f "claude" >/dev/null 2>&1; then
          echo "$pane $path"
        fi
      done' 2>/dev/null | while read -r pane path; do
      printf -- "- [%s]  %-30s %s\n" "$host" "$pane" "$path"
    done >> "$tmpfile"
  ) &
  pids+=($!)
done < "$HOSTS_FILE"

wait "${pids[@]}" 2>/dev/null
mv "$tmpfile" "$CACHE_FILE"
