{ pkgs, lib, ... }:
let
  ghostty = lib.getExe pkgs.ghostty;
  rofi = lib.getExe pkgs.rofi;
  wlr-randr = lib.getExe pkgs.wlr-randr;
  wallpaper_path = "$XDG_CONFIG_HOME/wallpaper/milkyway-window.png";
in
{
  imports = [
    ../rofi
    ../wallpaper
    ../waybar
  ];

  # Hyprland
  # ══════════════════════════════════════════════════════════════
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "ALT";

      general = {
        gaps_in = 0;
        gaps_out = 0;
      };

      animations.enabled = false;

      input = {
        natural_scroll = true;
      };

      bind = [
        # General
        "$mod, W, killactive"
        "$mod, Return, exec, ${ghostty}"
        "$mod, Space, exec, ${rofi} -show drun"
        "$mod, F, fullscreen"

        # Focus
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        # Theme toggle
        "$mod, T, exec, toggle-theme"

        # Monitors
        "$mod, D, exec, ${wlr-randr} --output eDP-1 --on"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [
        "systemctl --user set-environment XDG_CURRENT_DESKTOP=Hyprland"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user restart xdg-desktop-portal"
      ];
    };
  };

  # Wallpaper
  # ══════════════════════════════════════════════════════════════
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ wallpaper_path ];
      wallpaper = {
        monitor = "";
        path = wallpaper_path;
        fit_mode = "cover";
      };
      splash = false;
    };
  };

  # Autostart from tty-1
  # ══════════════════════════════════════════════════════════════
  programs.zsh.profileExtra = ''
    if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
      . $HOME/.nix-profile/etc/profile.d/nix.sh
    fi
    if [ -z "$WAYLAND_DISPLAY" ] && [ $(tty) = "/dev/tty1" ]; then
      exec dbus-run-session river
    fi
  '';

  # Desktop Portals
  # ══════════════════════════════════════════════════════════════
  xdg = {
    enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-wlr
        # pkgs.xdg-desktop-portal-gnome
      ];
      configPackages = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-wlr
        # pkgs.xdg-desktop-portal-gnome
      ];
      config.common = {
        default = [ "hyprland" "gtk" "wlr" ];
        # "org.freedesktop.impl.portal.Settings" = "gnome";
      };
    };
  };
}

