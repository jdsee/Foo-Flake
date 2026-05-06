{ pkgs
, lib
, config
, ...
}:
# TODO: Consider removing the user service, since system service runs already
let
  kanataExe = lib.getExe pkgs.kanata;
  configDir = "kanata";
  configFile = "kanata.kbd";
  configPath = "${config.xdg.configHome}/${configDir}/${configFile}";
in
{
  home.packages = with pkgs; [
    kanata
  ];

  xdg.configFile = {
    "${configDir}/${configFile}" = {
      text = builtins.readFile ./tap_esc_hold_ctrl.conf;
    };
  };

  systemd.user.services.kanata = {
    Unit = {
      Description = "Kanata Keyboard Remapper";
      Documentation = "https://github.com/jtroo/kanata";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${kanataExe} --cfg ${configPath}";
      Restart = "on-failure";
      RestartSec = "1s";
    };
  };
}
