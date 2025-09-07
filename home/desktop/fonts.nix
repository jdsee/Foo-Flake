{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.geist-mono
    font-awesome
    source-sans-pro
  ];

  fonts.fontconfig.enable = true;
}
