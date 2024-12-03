{ pkgs, ... }: {
  home.pointerCursor = {
    name = "WhiteSur-cursors";
    package = pkgs.whitesur-cursors;
  };
  gtk = {
    enable = true;
    font = {
      name = "GeistMono Nerd Font";
      size = 12;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "appmenu:none";
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "appmenu:none";
    };

    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };

    cursorTheme = {
      name = "WhiteSur-cursors";
      package = pkgs.whitesur-cursors;
    };

    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      # "Net/ThemeName" = "${gtk.theme.name}";
      # "Net/IconThemeName" = "${gtk.iconTheme.name}";
    };
  };
}
