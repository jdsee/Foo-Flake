{ ... }: {
  programs.yambar.enable = true;
  xdg.configFile."yambar/config.yml".source = ./config.yml;
}
