{ pkgs, ... }:
{
  imports = [
    ./foot.nix
    ./fonts.nix
    ./gammastep.nix
    ./gtk.nix
    ./kanata
    ./kanshi.nix
    ./mako.nix
    ./river
    ./rofi
    ./waybar
    ./wezterm
    ./zathura.nix
  ];

  # TODO: Add SDDM

  home.packages = with pkgs; [
    grim
    imv # simple image viewer
    mimeo
    pulseaudio
    slurp
    satty # screenshot annotator (swappy would be an alternative)
    wf-recorder
    wl-clipboard
    wl-mirror # mirror screen in separate window
    wlr-randr # manage monitors in wayland (xrandr alternative)
    nwg-displays
    wtype # automate typing input
    way-displays # Display Output Configurator
    waylock # Screen-Lock
    ydotool # automate user input (#TODO: why is wtype installed additionally?)
    xwaylandvideobridge
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
