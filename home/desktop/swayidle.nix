{ pkgs, lib, ... }:
let
  lockCmd = lib.getExe pkgs.waylock;
in
{
  home.packages = with pkgs; [
    wlopm
  ];
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = lockCmd;
      }
      {
        event = "lock";
        command = lockCmd;
      }
      # TODO: Turn on screen
      # {
      #   event = "after-resume";
      #   command = "swaymsg \"output * dpms on\"";
      # }
    ];
    timeouts = [
      {
        timeout = 285;
        command = "notify-send 'Screen will be locked in a moment'";
      }
      {
        timeout = 300; # 5 min
        command = lockCmd;
      }
      {
        timeout = 380; # 5.5 min
        command = "wlopm --off '*'";
        resumeCommand = "wlopm --on '*'";
      }
      {
        timeout = 1800; # 30 min
        command = "systemctl suspend";
      }
    ];
  };
}
