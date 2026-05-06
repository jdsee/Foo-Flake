{ config, ... }: {

  imports = [ ./config.nix ];

  xdg.configFile.wallpaper = {
    source = ./resources;
    recursive = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        config.wallpaper.light.primary
        config.wallpaper.light.secondary
        config.wallpaper.dark.primary
        config.wallpaper.dark.secondary
      ];
      wallpaper = [
        {
          monitor = "";
          path = config.wallpaper.dark.primary;
          fit_mode = "cover";
        }
        {
          monitor = "desc:${config.monitors.secondary}";
          path = config.wallpaper.dark.secondary;
          fit_mode = "cover";
        }
      ];
      splash = false;
      ipc = "on";
    };
  };
}
