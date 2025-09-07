{ pkgs, inputs, ... }:
let
  apps = with pkgs; [
    discord
    element-desktop
    ferdium
    # freecad
    chromium
    signal-desktop
    slack
    youtube-music
    # davinci-resolve <- buggy under wayland :(
  ];
  utils = with pkgs; [
    bitwarden
    brightnessctl
    exfatprogs
    gopass
    gparted
    lswt # list wayland toplevels
    networkmanagerapplet
    ntfs3g
    pamixer
    playerctl
    rustup
  ];
in
{
  imports = [
    ./nix.nix
    ./desktop
    ./lang/c.nix
    ./apps/firefox.nix
    ./apps/obs.nix
    ./apps/jetbrains
    ./apps/zathura.nix
    ./apps/zed.nix
  ];

  home.packages = apps ++ utils;

  nixpkgs.overlays = [
    inputs.nur.overlays.default
  ];
}
