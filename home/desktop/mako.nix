{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libnotify
  ];

  services.mako = {
    enable = true;
    font = "GeistMono Nerd Font 12";
    padding = "10,20";
    anchor = "top-right";
    borderSize = 2;
    defaultTimeout = 5000;
    width = 300;
    icons = false;

    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#11111b";
  };
}
