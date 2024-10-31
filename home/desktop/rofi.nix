{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      rofi-rbw
      rofi-power-menu
      rofi-emoji
      rofi-vpn
    ];
    theme = "Arc-Dark";
    font = "GeistMono Nerd Font 12";
    terminal = "${pkgs.wezterm}";
    cycle = true;
    pass = {
      enable = true;
      package = pkgs.rofi-pass-wayland;
      stores = [
        "/home/jdsee/.password-store"
      ];
    };
  };

  home.packages = with pkgs; [
    pinentry-rofi
    rofi-rbw
    rofi-power-menu
    bitwarden-menu
  ];

  xdg.configFile = {
    "rofi/rofi-themes-collection" = {
      source = pkgs.fetchFromGitHub {
        owner = "newmanls";
        repo = "rofi-themes-collection";
        rev = "5bc150394bf785b2751711e3050ca425c662938e";
        hash = "sha256-k737CFrtbGfpqBxBOhrAD/QRC0aDryFs0jB4fycUooI=";
      };
      recursive = true;
    };
  };
}
