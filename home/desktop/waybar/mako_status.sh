#! /usr/bin/env bash

if makoctl mode | grep -q mute; then
  echo '{ "text": "🕭", "class": "muted" }'
else
  echo '{ "text": "🕭", "class": "" }'
fi
