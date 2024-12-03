#! /usr/bin/env bash

# TODO: Share logic and configuration between `send-view.sh` and `focus-view.sh`

TARGET=$1

target_tags=$((1 << ("$TARGET" - 1)))
enabled_outputs=$(wlr-randr --json | jq '[.[] | select(.enabled == true)] | length')

if [ "$enabled_outputs" == 1 ]; then
  riverctl set-view-tags $target_tags
  riverctl set-focused-tags "$target_tags"
fi

tag_output_map[1]="DP-4"
tag_output_map[2]="DP-4"
tag_output_map[3]="DP-4"
tag_output_map[4]="DP-4"
tag_output_map[5]="DP-4"
tag_output_map[6]="DP-4"
tag_output_map[7]="DP-3"
tag_output_map[8]="DP-3"
tag_output_map[9]="DP-3"
tag_output_map[10]="DP-3"

target_output="${tag_output_map[$TARGET]}"
output_exists=$(
  wlr-randr --json |
  jq --arg target_output "$target_output" \
  '[.[] | select(.name == $target_output)] | length == 1'
)
if [ "$output_exists" == true ]; then
  riverctl send-to-output -current-tags "$target_output"
  riverctl focus-output "$target_output"
  riverctl set-view-tags "$target_tags"
  riverctl set-focused-tags "$target_tags"
else
  echo "WARNING: The configured output $target_output doesn't exist. Falling back to current output." >&2
  riverctl set-view-tags $target_tags
  riverctl set-focused-tags "$target_tags"
fi
