{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libnotify
  ];

  services.mako = {
    enable = true;
    settings = {
      font = "GeistMono Nerd Font 12";
      anchor = "top-left";
      default-timeout = 5000;
      icons = false;
      border-color = "#11111b";
      border-size = 2;
      padding = "10,20";
      width = 300;
      text-color = "#cdd6f4";
      background-color = "#1e1e2e";
    };


    extraConfig = ''
      [mode=mute]
      invisible=1
    '';
  };
}
