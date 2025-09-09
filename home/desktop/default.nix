{ pkgs, ... }: {
  imports = [
    ./flameshot.nix
    ./screenshot.nix
    ./fonts.nix
    ./foot.nix
    ./ghostty.nix
    ./gammastep.nix
    ./gtk.nix
    ./kanshi.nix
    ./mako.nix
    ./mime-types.nix
    ./rbw.nix
    ./river
    ./swayidle.nix
    ./toggle-theme.nix
    ./tofi
    ./wayland-pipewire-idle-inhibit.nix
    ./hyprlock.nix
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
    nwg-displays
    wtype # automate typing input
    waylock # Screen-Lock
    ydotool # automate user input (#TODO: why is wtype installed additionally?)
    kdePackages.xwaylandvideobridge
    nemo # filebrowser
  ];
}
