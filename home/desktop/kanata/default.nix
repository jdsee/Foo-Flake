{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kanata
  ];

  xdg.configFile = {
    "kanata/tap_esc_hold_ctrl.conf" = {
      text = builtins.readFile ./tap_esc_hold_ctrl.conf;
    };
  };

}
