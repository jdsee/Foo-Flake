{ pkgs
, lib
, ...
}:
let
  # waylock = lib.getExe pkgs.waylock;
  # lockCmd = "${waylock} -init-color 0x374231 -input-color 0x808b5d -ignore-empty-password";
  hyprlock = lib.getExe pkgs.hyprlock;
  lockCmd = "${hyprlock} --grace 5";
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
        timeout = 400;
        command = "notify-send 'Screen will be locked in a moment'";
      }
      {
        timeout = 420; # 7 min
        command = lockCmd;
      }
      # {
      #   timeout = 480; # 8 min
      #   command = "wlopm --off '*'";
      #   resumeCommand = "wlopm --on '*'";
      # }
      {
        timeout = 1800; # 30 min
        command = "systemctl suspend";
      }
    ];
  };
}
