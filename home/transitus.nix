{ pkgs, ... }:

{
  imports = [
    ./global.nix
    ./desktop
    ./apps/firefox.nix
    ./apps/obs.nix
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
    slack
    zed-editor # TODO: Move to Home-Manager
  ];

}
