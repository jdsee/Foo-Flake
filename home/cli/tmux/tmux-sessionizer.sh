#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    search_paths=$(find ~/projects -mindepth 2 -maxdepth 2 -type d)
    search_paths+=("\n${HOME}/coffee-notes")
    selected=$(find ~/projects -mindepth 2 -maxdepth 2 -type d | fzf --layout=reverse --preview "ls -la {}" --preview-window=right:50%)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
fi

if [[ -f "$selected"/.tmuxinator.yml ]]; then
  cd "$selected" || exit 1
  tmuxinator local
fi

if ! tmux has-session -t="$selected_name" 2> /dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

if [[ -z $TMUX ]]; then
    tmux attach -t "$selected_name"
else
    tmux switch-client -t "$selected_name"
fi
