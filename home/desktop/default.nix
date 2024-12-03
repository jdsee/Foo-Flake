{ pkgs, ... }: {
  imports = [
    ./flameshot.nix
    ./fonts.nix
    ./foot.nix
    ./gammastep.nix
    ./gtk.nix
    ./kanshi.nix
    ./mako.nix
    ./rbw.nix
    ./river
    ./swayidle.nix
    ./tofi
    ./wayland-pipewire-idle-inhibit.nix
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };

  home.packages = with pkgs; [
    imv # simple image viewer
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
    way-displays # Display Output Configurator (TODO: This should/could replace Kanshi at some point)
    waylock # Screen-Lock
    ydotool # automate user input (#TODO: why is wtype installed additionally?)
    xwaylandvideobridge
  ];
}
