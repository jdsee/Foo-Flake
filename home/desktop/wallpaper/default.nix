{ pkgs, ... }: {
  home.packages = [ pkgs.wbg ];

  xdg.configFile.wallpaper = {
    source = ./resources;
    recursive = true;
  };
}
