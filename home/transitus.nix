{ pkgs, ... }:

let
  apps = with pkgs; [
    signal-desktop
    slack
    youtube-music
    zed-editor # TODO: Move to Home-Manager
  ];
  utils = with pkgs; [
    bitwarden
    brightnessctl
    gopass
    lswt # List wayland toplevels
    networkmanagerapplet
    pamixer
    playerctl
  ];
in
{
  imports = [
    ./global.nix
    ./desktop
    ./lang/c.nix
    ./apps/firefox.nix
    ./apps/obs.nix
    ./apps/zathura.nix
    ./apps/intellij
  ];

  home.packages = apps ++ utils;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = [ ];
    };
  };
}
