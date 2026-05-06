{ pkgs, lib, config, ... }:
let
  brightnessctl = lib.getExe pkgs.brightnessctl;
  cliphist = lib.getExe pkgs.cliphist;
  firefox = lib.getExe pkgs.firefox;
  flameshot = lib.getExe pkgs.flameshot;
  ghostty = lib.getExe pkgs.ghostty;
  hyprlock = lib.getExe pkgs.hyprlock;
  kanshi = lib.getExe pkgs.kanshi;
  makoctl = lib.getExe pkgs.mako;
  nm-applet = lib.getExe pkgs.networkmanagerapplet;
  nu = lib.getExe pkgs.nushell;
  pamixer = lib.getExe pkgs.pamixer;
  playerctl = lib.getExe pkgs.playerctl;
  rofi = lib.getExe pkgs.rofi;
  waybar = lib.getExe pkgs.waybar;
  wl-paste = lib.getExe pkgs.wl-clipboard;
in
{
  imports = [
    ./waybar.nix
  ];

  # Hyprland
  # ══════════════════════════════════════════════════════════════
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 3;
        "col.active_border" = "rgba(ffac00ee)";
        "col.inactive_border" = "rgba(3b3b3baa)";
      };

      animations.enabled = false;

      workspace = [
        # Primary monitor (workspaces 1-6)
        "1, monitor:desc:${config.monitors.primary}"
        "2, monitor:desc:${config.monitors.primary}"
        "3, monitor:desc:${config.monitors.primary}"
        "4, monitor:desc:${config.monitors.primary}"
        "5, monitor:desc:${config.monitors.primary}"
        "6, monitor:desc:${config.monitors.primary}"

        # Secondary monitor (workspaces 7-10)
        "7,  monitor:desc:${config.monitors.secondary}"
        "8,  monitor:desc:${config.monitors.secondary}"
        "9,  monitor:desc:${config.monitors.secondary}"
        "10, monitor:desc:${config.monitors.secondary}"
      ];

      input = {
        natural_scroll = true;
        kb_options = "ctrl:nocaps,grp:alt_space_toggle,altwin:swap_alt_win,shift:both_capslock_cancel";
        kb_layout = "us,us";
        repeat_rate = 42;
        repeat_delay = 420;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
        };
      };

      bind = [
        # General
        "$mod, W, killactive"
        "$mod, F, fullscreen"
        "$mod SHIFT, Space, togglefloating"
        "$mod ALT, E, exit"
        "$mod ALT, L, exec, ${hyprlock} --grace 5"

        # Applications
        "$mod, Return, exec, ${ghostty}"
        "$mod, B, exec, ${firefox}"

        # Launchers
        "$mod,         Space, exec, ${rofi} -show drun"
        "$mod Control, Space, exec, ${nu} ${../rofi/rofi-gopass.nu}"
        "$mod Control, V    , exec, ${nu} ${../rofi/rofi-nm.nu} vpn"
        "$mod Control, W    , exec, ${nu} ${../rofi/rofi-nm.nu} wifi"
        "$mod Control, B    , exec, ${nu} ${../rofi/rofi-bt.nu}"
        "$mod Control, O    , exec, ${nu} ${../rofi/rofi-audio.nu} output"
        "$mod Control, I    , exec, ${nu} ${../rofi/rofi-audio.nu} input"
        "$mod Control, E    , exec, ${rofi} emoji"
        "$mod Control, F    , exec, ${rofi} filebrowser"

        # Misc.
        "$mod,       E, exec, $XDG_CONFIG_HOME/hypr/misc/nvim-input"
        "$mod Shift, E, exec, $XDG_CONFIG_HOME/hypr/misc/nvim-edit"
        "$mod,       U, exec, espanso cmd toggle"

        # Focus
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod, Tab, cyclenext"
        "$mod SHIFT, Tab, cyclenext, prev"

        # Move windows
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, L, movewindow, r"

        # Resize windows
        "$mod CTRL, H, resizeactive, -100 0"
        "$mod CTRL, J, resizeactive, 0 -100"
        "$mod CTRL, K, resizeactive, 0 100"
        "$mod CTRL, L, resizeactive, 100 0"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod, O, workspace, previous"

        # Move to workspaces
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Screenshots
        "$mod, S, exec, ${flameshot} gui"
        "$mod SHIFT, S, exec, shoot screen"
        "$mod CTRL, S, exec, shoot raw"

        # Theme toggle
        "$mod ALT, T, exec, toggle-theme"

        # Notifications
        "$mod, D, exec, ${makoctl} dismiss"
        "$mod ALT, D, exec, ${makoctl} mode -t mute"

        # Monitor focus
        "$mod, N, focusmonitor, +1"
        "$mod, P, focusmonitor, -1"
        "$mod SHIFT, N, movewindow, mon:+1"
        "$mod SHIFT, P, movewindow, mon:-1"
        "$mod CTRL, N, movecurrentworkspacetomonitor, +1"
        "$mod CTRL, P, movecurrentworkspacetomonitor, -1"
      ];

      bindl = [
        # Media keys
        ", XF86AudioRaiseVolume, exec, ${pamixer} -i 5"
        ", XF86AudioLowerVolume, exec, ${pamixer} -d 5"
        ", XF86AudioMute, exec, ${pamixer} --toggle-mute"
        ", XF86AudioMedia, exec, ${playerctl} play-pause"
        ", XF86AudioPlay, exec, ${playerctl} play-pause"
        ", XF86AudioPrev, exec, ${playerctl} previous"
        ", XF86AudioNext, exec, ${playerctl} next"
        ", XF86MonBrightnessUp, exec, ${brightnessctl} set +5%"
        ", XF86MonBrightnessDown, exec, ${brightnessctl} set 5%-"

        # Function keys
        ", F2, exec, ${playerctl} previous"
        ", F3, exec, ${playerctl} play-pause"
        ", F4, exec, ${playerctl} next"
        ", F6, exec, ${pamixer} -d 5"
        ", F7, exec, ${pamixer} --toggle-mute"
        ", F8, exec, ${pamixer} -i 5"
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

        # Applications
        "${waybar}"
        "${nm-applet}"
        "${flameshot}"
        "${kanshi}"
        "${wl-paste} -t text --watch ${cliphist} store"
        "${wl-paste} -t image --watch ${cliphist} store"
      ];
    };
  };

  # Autostart from tty-1
  # ══════════════════════════════════════════════════════════════
  programs.zsh.profileExtra = ''
    if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
      . $HOME/.nix-profile/etc/profile.d/nix.sh
    fi
    if [ -z "$WAYLAND_DISPLAY" ] && [ $(tty) = "/dev/tty1" ]; then
      exec start-hyprland
    fi
  '';

  # Desktop Portals / Extra Config
  # ══════════════════════════════════════════════════════════════
  xdg = {
    enable = true;

    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-wlr
      ];
      configPackages = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-wlr
      ];
      config.common = {
        default = [ "hyprland" "gtk" "wlr" ];
      };
    };

    configFile = {
      "hypr/misc/nvim-input" = {
        source = ./misc/nvim-input.sh;
        executable = true;
      };
      "hypr/misc/nvim-edit" = {
        source = ./misc/nvim-edit.sh;
        executable = true;
      };
    };
  };
}
