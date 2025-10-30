{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-rbw
      rofi-power-menu
      rofi-emoji
      rofi-vpn
    ];
    theme = "themes/minimal-fullscreen";
    font = "GeistMono Nerd Font 12";
    terminal = "$TERM";
    cycle = true;
    pass = {
      enable = true;
      package = pkgs.rofi-pass-wayland;
      stores = [
        "/home/jdsee/.password-store"
      ];
    };
    extraConfig = {
      matching = "glob";
    };
  };

  home.packages = with pkgs; [
    pinentry-rofi
    bitwarden-menu
  ];

  xdg.configFile = {
    "rofi/themes/minimal-fullscreen.rasi".source = ./minimal-fullscreen.rasi;
  };
}
