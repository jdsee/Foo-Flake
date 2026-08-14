{ pkgs, ... }: {
  imports = [
    # ./river
    ./espanso.nix
    ./flameshot.nix
    ./fonts.nix
    ./foot.nix
    ./gammastep.nix
    ./ghostty.nix
    ./gtk.nix
    ./hyprland
    ./hyprlock.nix
    ./kanshi.nix
    ./mako.nix
    ./mime-types.nix
    ./monitors.nix
    ./rbw.nix
    ./rofi
    ./screenshot.nix
    ./swayidle.nix
    ./tofi
    ./toggle-jira-locale.nix
    ./toggle-theme.nix
    ./wallpaper
    ./wayland-pipewire-idle-inhibit.nix
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };

  home.packages = with pkgs; [
    cliphist
    qimgv
    mimeo
    pulseaudio
    pavucontrol
    # wf-recorder
    wl-clipboard
    wl-color-picker
    wl-mirror # mirror screen in separate window
    wlr-randr # manage monitors in wayland (xrandr alternative)
    wdisplays
    wtype # automate typing input
    waylock # Screen-Lock
    ydotool # automate user input (#TODO: why is wtype installed additionally?)
    nemo # filebrowser
  ];
}
