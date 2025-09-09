{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.geist-mono
    nerd-fonts.jetbrains-mono
    inter-nerdfont
    font-awesome
    source-sans-pro
  ];

  fonts.fontconfig.enable = true;
}
