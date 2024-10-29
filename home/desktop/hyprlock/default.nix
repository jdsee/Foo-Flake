{ pkgs, ... }:
{

  home.packages = with pkgs; [
    hyprlock
  ];

  xdg.configFile = {
    "hypr/hyprlock.conf" = {
      text = builtins.readFile ./hyprlock.conf;
    };
  };
}
