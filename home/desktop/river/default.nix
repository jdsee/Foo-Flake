{ pkgs, ... }: {
  imports = [
    ../rofi
    ../wallpaper
    ../waybar
  ];

  home.packages = with pkgs; [
    wideriver
    river-bsp-layout
  ];

  # TODO: Figure out how to make this available to login-manager
  xdg.desktopEntries.river = {
    name = "River";
    exec = "river";
    type = "Application";
    categories = [ "System" ];
    mimeType = [ ];
  };

  xdg.configFile = {
    "river/reload" = {
      source = ./reload_river.sh;
      executable = true;
    };
    "river/focus-view" = {
      source = ./focus-view.sh;
      executable = true;
    };
    "river/send-view" = {
      source = ./send-view.sh;
      executable = true;
    };
    "river/nvim-input" = {
      source = ./nvim-input.sh;
      executable = true;
    };
    "river/nvim-edit" = {
      source = ./nvim-edit.sh;
      executable = true;
    };
  };

  wayland.windowManager.river = {
    enable = true;
    systemd.enable = true; # enables river-session.target, which links to graphical-session.target
    settings = {
      spawn = [
        "waybar"
        "nm-applet"
        "flameshot"
      ];
      map = {
        normal = {
          "Super W" = "close";
          "Super+Alt E" = "exit";
          "Super+Shift Space" = "toggle-float";
          "Super F" = "toggle-fullscreen";
          "Super+Alt R" = "spawn $XDG_CONFIG_HOME/river/reload";
          "Super+Alt L" = "spawn 'waylock -init-color 0x374231 -input-color 0x808b5d -ignore-empty-password'";
          "Super E" = "spawn $XDG_CONFIG_HOME/river/nvim-input";
          "Super+Shift E" = "spawn $XDG_CONFIG_HOME/river/nvim-edit";

          # Rofi
          "Super Space" = "spawn 'tofi-drun | xargs -I _ riverctl spawn _'";
          "Super+Control Space" = "spawn 'nu ${../tofi/tofi-pass.nu}'";
          "Super+Control V" = "spawn 'nu ${../tofi/tofi-nm.nu} vpn'";
          "Super+Control W" = "spawn 'nu ${../tofi/tofi-nm.nu} wifi'";
          "Super+Control B" = "spawn 'nu ${../tofi/tofi-bt.nu}'";

          # Applications
          "Super Return" = "spawn 'foot'";
          "Super b" = "spawn 'firefox'";

          # Notifications
          "Super D" = "spawn 'makoctl dismiss'";
          "Super+Alt D" = "spawn 'makoctl mode -t mute'";

          # Move focus
          "Super H" = "focus-view left";
          "Super J" = "focus-view down";
          "Super K" = "focus-view up";
          "Super L" = "focus-view right";

          # Swap views
          "Super+Shift H" = "swap left";
          "Super+Shift J" = "swap down";
          "Super+Shift K" = "swap up";
          "Super+Shift L" = "swap right";

          # Resize focused view
          "Super+Control H" = "resize horizontal -100";
          "Super+Control J" = "resize vertical -100";
          "Super+Control K" = "resize vertical 100";
          "Super+Control L" = "resize horizontal 100";

          # Snap
          "Super+Control+Shift H" = "snap left";
          "Super+Control+Shift J" = "snap down";
          "Super+Control+Shift K" = "snap up";
          "Super+Control+Shift L" = "snap right";

          # Screenshots
          "Super+Shift S" = "spawn 'flameshot gui'";
          "Super+Control S" = "spawn 'flameshot screen'";
          "Super+Control+Shift S" = "spawn 'flameshot full'";
        };
      };
    };
    extraConfig = ''
      # Environment
      export WLR_NO_HARDWARE_CURSORS=1

      riverctl spawn "wbg $XDG_CONFIG_HOME/wallpaper/Road-Trip_2560x1440.png &"

      # Mouse mappings
      riverctl map-pointer normal Super BTN_LEFT    move-view
      riverctl map-pointer normal Super BTN_RIGHT   resize-view
      riverctl map-pointer normal Super BTN_MIDDLE  toggle-float

      # Tags / Workspaces
      for i in $(seq 1 10)
      do
        key=$(("$i " % 10))
        tags=$((1 << ("$i " - 1)))
        riverctl map normal Super         "$key" spawn "$XDG_CONFIG_HOME/river/focus-view $i"
        riverctl map normal Super+Shift   "$key" spawn "$XDG_CONFIG_HOME/river/send-view $i"
        riverctl map normal Super+Alt     "$key" toggle-focused-tags "$tags"
        riverctl map normal Super+Control "$key" toggle-view-tags "$tags"
      done

      riverctl map normal Super O focus-previous-tags

      riverctl map normal Super N focus-output next
      riverctl map normal Super P focus-output previous
      riverctl map normal Super+Shift N send-to-output -current-tags next
      riverctl map normal Super+Shift P send-to-output -current-tags previous


      # Media-Keys
      for mode in normal locked
      do
          # Control pulse audio volume with pamixer (https://github.com/cdemoulins/pamixer)
          riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5'
          riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5'
          riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute'

          # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
          riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
          riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
          riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
          riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

          # Control screen backlight brightness with brightnessctl (https://github.com/Hummer12007/brightnessctl)
          riverctl map $mode None XF86MonBrightnessUp   spawn 'brightnessctl set +5%'
          riverctl map $mode None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'
      done

      riverctl map normal None F2 spawn 'playerctl previous'
      riverctl map normal None F3 spawn 'playerctl play-pause'
      riverctl map normal None F4 spawn 'playerctl next'

      riverctl map normal None F6 spawn 'pamixer -d 5'
      riverctl map normal None F7 spawn 'pamixer --toggle-mute'
      riverctl map normal None F8 spawn 'pamixer -i 5'

      # General
      riverctl default-attach-mode below
      riverctl focus-follows-cursor normal
      riverctl hide-cursor when-typing disabled
      riverctl set-cursor-warp on-focus-change
      riverctl set-repeat 42 420

      # Input-Configuration
      riverctl input 'pointer-*' natural-scroll enabled
      riverctl input 'pointer-*' tap enabled
      riverctl keyboard-layout \
        -options " ctrl:nocaps, grp:alt_space_toggle, altwin:swap_alt_win, shift:both_capslock_cancel " \
        "us,us"

      # Rules
      riverctl rule-add -app-id firefox ssd
      riverctl rule-add -app-id firefox -title '*Bitwarden*' float # FIXME: This isn't working yet
      riverctl rule-add -title "MainPicker" float
      riverctl rule-add -app-id nvim-input float
      riverctl rule-add -app-id dev.zed.Zed ssd
      riverctl rule-add -app-id org.pulseaudio.pavucontrol ssd
      riverctl rule-add -app-id gpartedbin ssd
      riverctl rule-add -app-id .blueman-manager-wrapped ssd

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
          --border-color-unfocused       "0x3b3b3b"  \
          --log-threshold                info        \
         > "/tmp/wideriver.$${XDG_VTNR}.$${USER}.log" 2>&1 &

      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river
      systemctl --user stop pipewire xdg-desktop-portal xdg-desktop-portal-wlr wireplumber
      systemctl --user start pipewire xdg-desktop-portal xdg-desktop-portal-wlr wireplumber
    '';
  };
}
