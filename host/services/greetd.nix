{ pkgs, ... }: {
  services.greetd = {
    enable = false;
    settings = {
      default_session.user = "jdsee";
    };
  };

  programs.regreet = {
    enable = false;
    cageArgs = [ "-d" "-s" "-m" "last" ];
    settings = {
      background = {
        path = "/etc/greetd/wallpaper";
        fit = "Cover";
      };
      theme = {
        name = "WhiteSur-Dark";
        package = pkgs.whitesur-gtk-theme;
      };
      cursorTheme = {
        name = "WhiteSur-Dark";
        package = pkgs.whitesur-cursors;
      };
      font = {
        name = "GeistMono Nerd Font";
        package = pkgs.geist-font;
        size = 14;
      };
    };
  };

  environment.etc = {
    "greetd/wallpaper".source = ../../home/desktop/wallpaper/resources/Road-Trip_2560x1440.png;
    "greetd/environments".text = ''
      river
      zsh
    '';
  };
}
