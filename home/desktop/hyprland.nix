{ ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "ALT";

      bind = [
        # Basic window management
        "$mod, W, killactive"
        "$mod, Return, exec, ghostty"
        "$mod, Space, exec, rofi -show drun"
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
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
