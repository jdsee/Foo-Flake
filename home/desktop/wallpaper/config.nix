{ lib, ... }: {
  options = {
    wallpaper = {
      light = {
        primary = lib.mkOption {
          type = lib.types.str;
          default = "$XDG_CONFIG_HOME/wallpaper/zen-coder-light.png";
          description = "Light theme primary monitor wallpaper";
        };
        secondary = lib.mkOption {
          type = lib.types.str;
          default = "$XDG_CONFIG_HOME/wallpaper/zen-coder-portrait-light.png";
          description = "Light theme secondary monitor wallpaper";
        };
      };
      dark = {
        primary = lib.mkOption {
          type = lib.types.str;
          default = "$XDG_CONFIG_HOME/wallpaper/zen-coder-dark.png";
          description = "Dark theme primary monitor wallpaper";
        };
        secondary = lib.mkOption {
          type = lib.types.str;
          default = "$XDG_CONFIG_HOME/wallpaper/zen-coder-portrait-dark.png";
          description = "Dark theme secondary monitor wallpaper";
        };
      };
    };
  };

  config = {
    wallpaper = {
      light = {
        primary = "$XDG_CONFIG_HOME/wallpaper/zen-coder-light.png";
        secondary = "$XDG_CONFIG_HOME/wallpaper/zen-coder-portrait-light.png";
      };
      dark = {
        primary = "$XDG_CONFIG_HOME/wallpaper/zen-coder-dark.png";
        secondary = "$XDG_CONFIG_HOME/wallpaper/zen-coder-portrait-dark.png";
      };
    };
  };
}
