#!/usr/bin/env bash

set -euo pipefail

file="$1"
backup_ext=''${2:-tinker} # TODO: only default works atm

if [[ "''${file}" != /* ]]; then
  file=$(cd "$(dirname "''${file}")" && pwd)/$(basename "''${file}")
fi

if [[ ! -f "''${file}" ]]; then
  echo "ERROR: '$file' is not a regular file" >&2
  exit 1
fi

backup="''${file}.''${backup_ext}"

if [[ -f "''${backup}" ]]; then
  echo "Reusing existing tinker file"
  nvim "''${file}"
  exit 0
fi

mv "''${file}" "''${backup}"
cp "''${backup}" "''${file}"
chmod +w "''${file}"
echo "''${file}" >> "''${XDG_STATE_HOME:?}/tinkerfile"
nvim "''${file}"
# TODO: reset, if no diff to backup
