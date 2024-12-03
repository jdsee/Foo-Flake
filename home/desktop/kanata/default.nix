{ pkgs
, lib
, config
, ...
}:
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
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Environment = [ "DISPLAY=:0" ];
      Type = "simple";
      ExecStart = "${kanataExe} --cfg ${configPath}";
      Restart = "no";
    };
  };
}
