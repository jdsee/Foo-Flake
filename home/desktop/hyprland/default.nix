{ ... }: {
  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.configFile = {
    "hypr/clean_start_xdg_desktop_portal_hyprland.sh".source = ./clean_start_xdg_desktop_portal_hyprland.sh;
    "xdg-desktop-portals/hyprland-portals.conf".text = ''
      [preferred]
      default=hyprland;gtk
      org.freedesktop.impl.portal.FileChooser=gnome
    '';
  };
}
