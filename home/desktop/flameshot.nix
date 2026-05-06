{ pkgs, ... }:
{
  home.packages = [
    pkgs.grim
  ];
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
      };
    };
  };
}
