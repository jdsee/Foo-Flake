{ pkgs, ... }:

{
  imports = [
    ../waybar
    ./i3bar.nix
  ];

  home.packages = with pkgs; [
    networkmanagerapplet
    wideriver
  ];

  wayland.windowManager.river = {
    enable = true;
    systemd.enable = true; # enables river-session.target, which links to graphical-session.target
    settings = {
      spawn = [
        "waybar"
        "nm-applet"
        "foot -a terminal"
      ];
      map = {
        normal = {
          "Super W         " = "close";
          "Super+Shift E         " = "exit";
          "Super+Shift Space     " = "toggle-float";
          "Super F         " = "toggle-fullscreen";

          # Applications
          "Super Return    " = "spawn 'foot'";
          "Super Space     " = "spawn 'rofi -show drun'";

          # Move focus
          "Super H         " = "focus-view left";
          "Super J         " = "focus-view down";
          "Super K         " = "focus-view up";
          "Super L         " = "focus-view right";

          # Swap views
          "Super+Control H         " = "swap left";
          "Super+Control J         " = "swap down";
          "Super+Control K         " = "swap up";
          "Super+Control L         " = "swap right";

          # Resize focused view
          "Super+Shift H         " = "resize horizontal -100";
          "Super+Shift J         " = "resize vertical -100";
          "Super+Shift K         " = "resize vertical 100";
          "Super+Shift L         " = "resize horizontal 100";
        };
      };
    };
    extraConfig = ''
      # Mouse mappings
      riverctl map-pointer normal Super BTN_LEFT    move-view
      riverctl map-pointer normal Super BTN_RIGHT   resize-view
      riverctl map-pointer normal Super BTN_MIDDLE  toggle-float

      # Tags / Workspaces
      for i in $(seq 1 9)
      do
        tags=$((1 << ("$i" - 1)))
        riverctl map normal Super "$i" set-focused-tags $tags
      done

      riverctl map normal Super O focus-previous-tags

      # General
      riverctl default-attach-mode below
      riverctl focus-follows-cursor normal
      riverctl hide-cursor when-typing enabled
      riverctl set-cursor-warp on-focus-change
      riverctl set-repeat 50 420

      # Input-Configuration
      riverctl input 'pointer-*' natural-scroll enabled
      riverctl input 'pointer-*' tap enabled
      riverctl keyboard-layout \
        -options "ctrl:nocaps, grp:alt_space_toggle, altwin:swap_alt_win, shift:both_capslock_cancel" \
        "us,us"

      # Layout
      riverctl default-layout wideriver
      wideriver \
          --layout                       left        \
          --layout-alt                   monocle     \
          --stack                        dwindle     \
          --count-master                 1           \
          --ratio-master                 0.50        \
          --count-wide-left              0           \
          --ratio-wide                   0.35        \
          --no-smart-gaps                            \
          --inner-gaps                   0           \
          --outer-gaps                   0           \
          --border-width                 2           \
          --border-width-monocle         0           \
          --border-width-smart-gaps      0           \
          --border-color-focused         "0x93a1a1"  \
          --border-color-focused-monocle "0x586e75"  \
          --border-color-unfocused       "0x586e75"  \
          --log-threshold                info        \
         > "/tmp/wideriver.$${XDG_VTNR}.$${USER}.log" 2>&1 &
    '';
  };

}
