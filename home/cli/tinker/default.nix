{ pkgs, ... }:
let
  tinker = pkgs.writeShellScriptBin "tinker" ''
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
  '';

  tinker-rev = pkgs.writeShellScriptBin "tinker-rev" ''
    if [ -f "$1" ]; then
      echo "Reverting $1"
      rm "$1"
      mv "$1.tinker" "$1"
      sed -i "\#$PWD/$1#d" "$XDG_STATE_HOME/tinkerfile"
      exit 0
    fi
    if [ -z "$1" ]; then
      choice=$(cat "$XDG_STATE_HOME/tinkerfile" | fzf)
      if [ -z "$choice" ]; then
        echo "Nothing Selected"
        exit 1
      fi
      rm "$choice"
      mv "$choice.tinker" "$choice"
      sed -i "\#$choice#d" "$XDG_STATE_HOME/tinkerfile"
      exit 0
    fi
    if [[ "$1" -eq "-a" ]]; then
      for file in $(cat "$XDG_STATE_HOME/tinkerfile"); do
        echo "Reverting $file"
        rm "$file"
        mv "$file.tinker" "$file"
        rm "$XDG_STATE_HOME/tinkerfile"
      done
      exit 0
    fi
  '';

  tinker-diff = pkgs.writeShellScriptBin "tinker-diff" ''
    for file in $(cat "$XDG_STATE_HOME/tinkerfile"); do
      echo "------------------------------------------------------------"
      echo "DIFF for $file"
      echo "------------------------------------------------------------"
      diff "$file.tinker" "$file"
    done
    exit 0
  '';
in
{
  home.packages = [
    tinker
    tinker-rev
    tinker-diff
  ];
}
