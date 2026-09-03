{ pkgs, ... }:
{
  home.packages = with pkgs; [ mux ];

  xdg.configFile = {
    "tmuxinator" = {
      source = ./tmuxinator;
      recursive = true;
    };
  };
}
