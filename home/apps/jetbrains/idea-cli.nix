{ pkgs, ... }:
let
  idea-cli = pkgs.writeShellScriptBin "idea" ''
    #!/usr/bin/env sh
    PROJECT=''${1:-.}
    NOW=$(date +%F-%T%z)
    LOG_FILE="/tmp/idea-ultimate_''${NOW}.log"
    idea-ultimate "''${PROJECT}" > "''${LOG_FILE}" 2> "''${LOG_FILE}" &
    disown
  '';
in
{
  home.packages = [
    idea-cli
  ];
}
