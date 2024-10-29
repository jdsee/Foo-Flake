{ pkgs, ... }:
{
  home.packages = with pkgs; [
    geist-font
    nerdfonts
  ];

  fonts.fontconfig.enable = true;
}
