#! /usr/bin/env bash

tmp_file=/tmp/nvim-input.$(date +%F-%s).md

wl-copy --clear
wtype -M ctrl -k a -k c -m ctrl -s 200
wl-paste > "$tmp_file"
truncate -s -1 "$tmp_file" # drop trailing newline

# TODO improve nvim startup speed
foot --app-id nvim-input \
  nvim "$tmp_file" \
  -c "UmlautsEnable" \
  -c "set showtabline=0" \
  -c "inoremap <c-j> <cmd>wq<cr>" \
  -c "norm G$"

wl-copy < "$tmp_file"
sleep 0.1
wtype -s 100 -M ctrl -k v -m ctrl
rm "$tmp_file"

