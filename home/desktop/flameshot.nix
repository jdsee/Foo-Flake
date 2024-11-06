{ pkgs, ... }:
{
  home.packages = [ pkgs.grim ];
  services.flameshot = {
    enable = true;
    package = pkgs.flameshot-grim;
    settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
      };
    };
  };
}
