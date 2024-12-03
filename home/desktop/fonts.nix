{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.geist-mono
    font-awesome
  ];

  fonts.fontconfig.enable = true;
}
