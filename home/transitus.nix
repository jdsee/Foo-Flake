{ pkgs, ... }:

{
  imports = [
    ./global.nix
    ./desktop
    ./desktop/river
    ./desktop/hyprland
    ./apps/firefox.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = [ ];
    };
  };

  home.packages = with pkgs; [
    bitwarden
    brightnessctl
    gopass
    lswt # List wayland toplevels
    networkmanagerapplet
    pamixer
    playerctl
    signal-desktop
    zed-editor
  ];

}
