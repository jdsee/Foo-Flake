{ pkgs, ... }:
{
  home.packages = with pkgs; [
    geist-font
    nerdfonts
    font-awesome
  ];

  fonts.fontconfig.enable = true;
}
