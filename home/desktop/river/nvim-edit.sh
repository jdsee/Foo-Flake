#! /usr/bin/env bash

tmp_file=/tmp/nvim-edit.$(date +%F-%s).md

wl-copy --clear
wtype -M ctrl -k a -k c -m ctrl -s 200
wl-paste > "$tmp_file"
truncate -s -1 "$tmp_file" # drop trailing newline

# TODO improve nvim startup speed
foot --app-id nvim-edit \
  nvim "$tmp_file" \
  -c "Telescope filetypes"
